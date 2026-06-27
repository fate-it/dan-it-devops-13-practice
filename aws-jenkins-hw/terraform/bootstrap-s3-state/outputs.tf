output "tfstate_bucket_name" {
  value       = aws_s3_bucket.tfstate.bucket
  description = "S3 bucket for Terraform remote state"
}

output "backend_example" {
  value = <<EOT
terraform {
  backend "s3" {
    bucket       = "${aws_s3_bucket.tfstate.bucket}"
    key          = "jenkins-homework/infra/terraform.tfstate"
    region       = "${var.region}"
    encrypt      = true
    use_lockfile = true
  }
}
EOT
}
