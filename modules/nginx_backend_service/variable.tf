variable "backend_service_name" {}
variable "protocol" { default = "HTTP" }
variable "load_balancing_scheme" { default = "EXTERNAL" }
variable "health_checks" {}
variable "backend_group" {}
