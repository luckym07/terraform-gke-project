variable "health_check_name" {}
variable "port" { default = 80 }
variable "request_path" { default = "/healthz" }
variable "check_interval_sec" { default = 10 }
variable "timeout_sec" { default = 5 }
variable "healthy_threshold" { default = 2 }
variable "unhealthy_threshold" { default = 3 }
