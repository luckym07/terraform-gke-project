variable "namespace" {
  description = "Namespace for the NGINX ingress controller"
  type        = string
}

variable "chart" {
  description = "Helm chart name"
  type        = string
}

variable "repository" {
  description = "Helm chart repository URL"
  type        = string
}

variable "version" {
  description = "Helm chart version"
  type        = string
}

variable "values_file" {
  description = "Path to the values file for Helm release"
  type        = string
}
