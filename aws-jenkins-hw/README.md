# AWS Terraform + Ansible + Jenkins homework

This repository contains a full homework scaffold:

- Terraform bootstrap for an S3 remote state bucket
- Terraform infrastructure: VPC, public subnet, private subnet, IGW, NAT Gateway, Jenkins master EC2 on-demand, Jenkins worker EC2 spot
- Ansible playbook for Jenkins LTS + nginx reverse proxy
- Jenkinsfile for Step project 2 style Node.js/Docker pipeline

## 0. Local requirements

Install locally:

- Terraform >= 1.10
- AWS CLI configured with credentials
- Ansible
- SSH client

On Arch Linux:

```bash
sudo pacman -S terraform aws-cli ansible openssh
```

## 1. Generate SSH key

```bash
mkdir -p generated
ssh-keygen -t ed25519 -f generated/jenkins_hw_ed25519 -C jenkins-hw -N ""
```

## 2. Create S3 bucket for Terraform state

```bash
cd terraform/bootstrap-s3-state
terraform init
terraform apply \
  -var="region=eu-central-1" \
  -var="project_name=jenkins-hw-serhii"
```

Copy `tfstate_bucket_name` from the output.

## 3. Configure remote backend for infrastructure

```bash
cd ../infra
cp backend.tf.example backend.tf
nano backend.tf
```

Replace `CHANGE_ME_FROM_BOOTSTRAP_OUTPUT` with the S3 bucket name from step 2.

## 4. Create AWS infrastructure

Get your current public IP:

```bash
MY_IP="$(curl -s https://checkip.amazonaws.com)/32"
PUB_KEY="$(cat ../../generated/jenkins_hw_ed25519.pub)"
```

Run Terraform:

```bash
terraform init
terraform plan \
  -var="allowed_ssh_cidr=$MY_IP" \
  -var="ssh_public_key=$PUB_KEY"

terraform apply \
  -var="allowed_ssh_cidr=$MY_IP" \
  -var="ssh_public_key=$PUB_KEY"
```

Save outputs: `jenkins_url`, `master_public_ip`, `worker_private_ip`.

## 5. Create Ansible inventory

From the repository root:

```bash
MASTER_PUBLIC_IP="PASTE_TERRAFORM_OUTPUT_MASTER_PUBLIC_IP"
cat > ansible/inventory.ini <<EOF_INV
[jenkins_master]
$MASTER_PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=../generated/jenkins_hw_ed25519
EOF_INV
```

Test SSH:

```bash
ssh -i generated/jenkins_hw_ed25519 ubuntu@$MASTER_PUBLIC_IP
```

## 6. Install Jenkins and nginx by Ansible

```bash
cd ansible
ansible-playbook -i inventory.ini playbooks/jenkins-master.yml
```

Get initial Jenkins admin password:

```bash
ssh -i ../generated/jenkins_hw_ed25519 ubuntu@$MASTER_PUBLIC_IP \
  'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'
```

Open Jenkins:

```text
http://MASTER_PUBLIC_IP
```

## 7. Manual Jenkins setup

1. Install suggested plugins.
2. Create the admin user.
3. Install/check plugin: **SSH Build Agents**.
4. Add SSH private key credential:
   - Kind: SSH Username with private key
   - Username: `jenkins`
   - Private Key: content of `generated/jenkins_hw_ed25519`
5. Add DockerHub credential:
   - Kind: Username with password
   - ID: `docker-hub-creds`
   - Username: DockerHub username
   - Password: DockerHub token/password
6. Add node:
   - Name: `jenkins-worker`
   - Type: Permanent Agent
   - Remote root directory: `/home/jenkins/agent`
   - Labels: `jenkins-worker`
   - Launch method: Launch agents via SSH
   - Host: Terraform output `worker_private_ip`
   - Credentials: SSH private key credential from step 4
   - Host key verification: for lab you can use manually trusted/accept first connection

## 8. Pipeline

Use `jenkins/Jenkinsfile` in your Step project 2 repository or copy its content into the Jenkins job.

Expected worker label: `jenkins-worker`.
Expected DockerHub credential ID: `docker-hub-creds`.

## 9. Destroy all resources

Destroy infrastructure first:

```bash
cd terraform/infra
terraform destroy \
  -var="allowed_ssh_cidr=$MY_IP" \
  -var="ssh_public_key=$PUB_KEY"
```

Then destroy the S3 state bucket:

```bash
cd ../bootstrap-s3-state
terraform destroy \
  -var="region=eu-central-1" \
  -var="project_name=jenkins-hw-serhii"
```

Take screenshots of both destroy outputs.
