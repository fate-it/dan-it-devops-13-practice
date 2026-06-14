variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_id" {
  description = "VPC ID where EC2 and Security Group will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of TCP ports opened from anywhere"
  type        = list(number)
  default     = [22, 80]
}