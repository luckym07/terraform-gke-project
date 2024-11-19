variable "manifests" {
  description = "List of Kubernetes manifest configurations"
  type = map(object({
    file_path = string
  }))
}