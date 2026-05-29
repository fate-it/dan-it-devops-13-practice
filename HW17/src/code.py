import json
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    
    filters = [
        {
            'Name': 'instance-state-name',
            'Values': ['running']
        },
        {
            'Name': 'tag:Environment',  
            'Values': ['Development']    
        }
    ]
    
    response = ec2.describe_instances(Filters=filters)
    
    instances_to_stop = []
    
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instances_to_stop.append(instance['InstanceId'])
            

    if instances_to_stop:
        print(f"Знайдено інстанси для зупинки: {instances_to_stop}")
        ec2.stop_instances(InstanceIds=instances_to_stop)
        return {
            'statusCode': 200,
            'body': json.dumps(f"Успішно зупинено інстанси: {instances_to_stop}")
        }
    else:
        print("Працюючих інстансів з таким тегом не знайдено.")
        return {
            'statusCode': 200,
            'body': json.dumps("Немає інстансів для зупинки.")
        }