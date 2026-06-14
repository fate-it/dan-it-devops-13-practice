output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.nginx.public_ip
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.nginx.id
}

output "security_group_id" {
  description = "Created security group ID"
  value       = aws_security_group.nginx_sg.id
}