variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project prefix for names"
  type        = string
  default     = "jenkins-hw"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name. Leave empty to generate one."
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "For homework cleanup only: allow bucket deletion with objects inside."
  type        = bool
  default     = true
}
