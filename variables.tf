variable "http_service_ami" {
  description = "AMI ID"
  type        = string
}

variable "worker_ami" {
  description = "AMI ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
