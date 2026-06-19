output "ec2_public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.web[*].public_ip
}

output "nginx_urls" {
  description = "Nginx URLs"
  value       = [for ip in aws_instance.web[*].public_ip : "http://${ip}"]
}

output "ansible_inventory_file" {
  description = "Generated Ansible inventory file"
  value       = abspath(local_file.ansible_inventory.filename)
}

output "ssh_private_key_path" {
  description = "Generated SSH private key path"
  value       = abspath(local.private_key_path)
}