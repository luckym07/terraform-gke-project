variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "region" {
  description = "The region to deploy the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}