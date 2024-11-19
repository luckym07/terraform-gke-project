resource "google_compute_url_map" "nginx_url_map" {
  name            = var.url_map_name
  default_service = var.default_service
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = var.proxy_name
  url_map = google_compute_url_map.nginx_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = var.forwarding_rule_name
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = var.port_range
  ip_address = var.ip_address
}
