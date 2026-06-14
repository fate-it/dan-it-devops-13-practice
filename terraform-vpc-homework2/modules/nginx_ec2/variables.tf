variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "list_of_open_ports" {
  description = "List of TCP ports opened from anywhere"
  type        = list(number)
}