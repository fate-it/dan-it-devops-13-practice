output "instance_public_ip" {
  description = "Public IP of created EC2 instance"
  value       = module.nginx_ec2.instance_public_ip
}

output "nginx_url" {
  description = "URL to check Nginx"
  value       = "http://${module.nginx_ec2.instance_public_ip}"
}