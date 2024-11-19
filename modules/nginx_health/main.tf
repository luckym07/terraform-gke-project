resource "google_compute_health_check" "nginx_health_check" {
  name               = var.health_check_name
  http_health_check {
    port               = var.port
    request_path       = var.request_path
    check_interval_sec = var.check_interval_sec
    timeout_sec        = var.timeout_sec
    healthy_threshold  = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}
