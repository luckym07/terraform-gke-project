output "health_check_id" {
  value = google_compute_health_check.nginx_health_check.id
}
