variable "PROJECT_ID" {
  description = "The name of the GCP project id"
  type        = string
}

variable "VPC_NAME" {
  description = "Name of the VPC"
  type        = string
}

variable "SUBNET_NAME" {
  description = "Name of the subnet"
  type        = string
}

variable "REGION" {
  description = "Region for resources"
  type        = string
}

variable "CIDR_BLOCK" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "GKE_CLUSTER_NAME" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "MASTER_CIDR_BLOCK" {
  description = "CIDR block for GKE master nodes"
  type        = string
}

variable "MACHINE_TYPE" {
  description = "Machine type for GKE nodes"
  type        = string
}

variable "NODE_POOL_NAME" {
  description = "Name of the GKE node pool"
  type        = string
}

variable "NODE_COUNT" {
  description = "Number of nodes in the GKE node pool"
  type        = number
}

variable "NODE_MACHINE_TYPE" {
  description = "Machine type for node pool nodes"
  type        = string
}

variable "NODE_PREEMPTIBLE" {
  description = "Whether the node pool nodes are preemptible"
  type        = bool
}

variable "NAMESPACE" {
  description = "Kubernetes namespace for resources"
  type        = string
}

variable "SSL_SECRET_NAME" {
  description = "Name of the Kubernetes secret for SSL certificates"
  type        = string
}

variable "NGINX_NAMESPACE" {
  description = "Namespace for NGINX ingress"
  type        = string
}

variable "NGINX_CHART" {
  description = "Helm chart name for NGINX ingress"
  type        = string
}

variable "NGINX_REPOSITORY" {
  description = "Helm repository URL for NGINX ingress"
  type        = string
}

variable "NGINX_VERSION" {
  description = "Version of the NGINX ingress Helm chart"
  type        = string
}

variable "NGINX_VALUES_FILE" {
  description = "Values file for the NGINX ingress Helm chart"
  type        = string
}

variable "ZSCALER_POLICY_NAME" {
  description = "Name of the Zscaler security policy"
  type        = string
}

variable "ZSCALER_POLICY_DESCRIPTION" {
  description = "Description of the Zscaler security policy"
  type        = string
}

variable "ZSCALER_POLICY_RULES" {
  description = "Rules for the Zscaler security policy"
  type        = list(object({
    action         = string
    priority       = number
    versioned_expr = string
    ip_ranges      = list(string)
  }))
}

variable "HEALTH_CHECK_NAME" {
  description = "Name of the health check"
  type        = string
}

variable "BACKEND_SERVICE_NAME" {
  description = "Name of the backend service"
  type        = string
}

variable "BACKEND_PROTOCOL" {
  description = "Protocol for the backend service"
  type        = string
}

variable "LOAD_BALANCING_SCHEME" {
  description = "Load balancing scheme for the backend service"
  type        = string
}

variable "URL_MAP_NAME" {
  description = "Name of the URL map"
  type        = string
}

variable "PROXY_NAME" {
  description = "Name of the HTTP proxy"
  type        = string
}

variable "FORWARDING_RULE_NAME" {
  description = "Name of the forwarding rule"
  type        = string
}

variable "FORWARDING_RULE_IP" {
  description = "IP address for the forwarding rule"
  type        = string
}
