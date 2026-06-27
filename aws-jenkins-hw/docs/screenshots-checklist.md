# Screenshot checklist for submission

1. GitHub repository with folders: `terraform`, `ansible`, `jenkins`.
2. `terraform/bootstrap-s3-state`: `terraform init`.
3. `terraform/bootstrap-s3-state`: `terraform apply` output with S3 bucket name.
4. AWS Console: created S3 bucket, versioning enabled, public access blocked.
5. `terraform/infra/backend.tf` with the created bucket name.
6. `terraform/infra`: `terraform init` using S3 backend.
7. `terraform/infra`: `terraform plan` summary.
8. `terraform/infra`: `terraform apply` summary and outputs.
9. AWS Console: VPC.
10. AWS Console: public subnet for Jenkins master and private subnet for worker.
11. AWS Console: Internet Gateway attached to VPC.
12. AWS Console: NAT Gateway in public subnet.
13. AWS Console: route table for public subnet with route to IGW.
14. AWS Console: route table for private subnet with route to NAT Gateway.
15. AWS Console: EC2 Jenkins master as on-demand instance.
16. AWS Console: EC2 Jenkins worker as spot instance.
17. AWS Console: security groups: master SSH/HTTP, worker SSH only from master SG.
18. Local terminal: `ansible-playbook -i ansible/inventory.ini ansible/playbooks/jenkins-master.yml` success.
19. Browser: Jenkins opens through `http://MASTER_PUBLIC_IP` via nginx.
20. SSH terminal: command showing initial Jenkins password.
21. Jenkins setup: installed suggested plugins.
22. Jenkins plugins: SSH Build Agents plugin installed.
23. Jenkins credentials: SSH private key credential for worker.
24. Jenkins node config: worker host private IP, label `jenkins-worker`, remote root `/home/jenkins/agent`.
25. Jenkins node page: `Agent successfully connected and online`.
26. Jenkins credentials: DockerHub credential with ID `docker-hub-creds`.
27. Jenkins pipeline job config with GitHub repo and Jenkinsfile path.
28. Jenkins build console output: Checkout, Test, Docker Build, Docker Push completed.
29. DockerHub: pushed image/tag, if your Step project 2 requires DockerHub proof.
30. `terraform/infra`: `terraform destroy` output.
31. AWS Console: EC2/VPC/NAT resources deleted.
32. `terraform/bootstrap-s3-state`: `terraform destroy` output for S3 state bucket.
