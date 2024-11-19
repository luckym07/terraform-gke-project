variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region to deploy the GKE cluster"
  type        = string
}

variable "network_id" {
  description = "The ID of the network to which the GKE cluster will connect"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet in which the GKE cluster will be deployed"
  type        = string
}

variable "master_cidr_block" {
  description = "CIDR block for the private master endpoint"
  type        = string
}

variable "machine_type" {
  description = "The machine type for GKE nodes"
  type        = string
}