output "backend_service_self_link" {
  value = google_compute_backend_service.nginx_backend_service.self_link
}
