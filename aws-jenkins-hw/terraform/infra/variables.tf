variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Prefix for all resources"
  type        = string
  default     = "jenkins-hw"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "allowed_ssh_cidr" {
  description = "Your public IP in CIDR format, e.g. 1.2.3.4/32. Do not use 0.0.0.0/0 in real projects."
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key text that cloud-init writes into authorized_keys"
  type        = string
}

variable "master_instance_type" {
  type    = string
  default = "t3.small"
}

variable "worker_instance_type" {
  type    = string
  default = "t3.small"
}

variable "worker_spot_max_price" {
  description = "Optional max spot price. Empty means AWS uses current spot market behavior without explicit max."
  type        = string
  default     = ""
}
