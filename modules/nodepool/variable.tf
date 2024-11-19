variable "node_pool_name" {
  description = "The name of the node pool"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "region" {
  description = "The region to deploy the node pool"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
}

variable "machine_type" {
  description = "The machine type for the node pool"
  type        = string
}

variable "preemptible" {
  description = "Whether to use preemptible VMs for the node pool"
  type        = bool
}