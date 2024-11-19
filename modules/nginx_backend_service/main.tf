resource "google_compute_backend_service" "nginx_backend_service" {
  name                 = var.backend_service_name
  protocol             = var.protocol
  load_balancing_scheme = var.load_balancing_scheme
  health_checks        = var.health_checks

  backend {
    group = var.backend_group
  }
}
