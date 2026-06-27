output "jenkins_url" {
  value = "http://${aws_instance.jenkins_master.public_ip}"
}

output "master_public_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "master_private_ip" {
  value = aws_instance.jenkins_master.private_ip
}

output "worker_private_ip" {
  value = aws_instance.jenkins_worker_spot.private_ip
}

output "ssh_to_master" {
  value = "ssh -i ../../generated/jenkins_hw_ed25519 ubuntu@${aws_instance.jenkins_master.public_ip}"
}

output "ansible_inventory" {
  value = <<EOT
[jenkins_master]
${aws_instance.jenkins_master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../generated/jenkins_hw_ed25519
EOT
}

output "jenkins_worker_setup_note" {
  value = "In Jenkins node config use host=${aws_instance.jenkins_worker_spot.private_ip}, user=jenkins, remote root=/home/jenkins/agent, label=jenkins-worker."
}
