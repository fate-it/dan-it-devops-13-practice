terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket = "terraform-state-danit-devops-360496493965"
    key    = "kuzmenkoserhii053/terraform-vpc-homework2/terraform.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}