# Output the name of the Helm release
output "nginx_ingress_release_name" {
  value       = helm_release.nginx_ingress.name
  description = "The name of the NGINX Ingress Helm release"
}

# Output the namespace where the Helm release is deployed
output "nginx_ingress_namespace" {
  value       = helm_release.nginx_ingress.namespace
  description = "The namespace where the NGINX Ingress is deployed"
}

# Output the status of the Helm release (e.g., 'deployed', 'failed', etc.)
output "nginx_ingress_status" {
  value       = helm_release.nginx_ingress.status
  description = "The status of the NGINX Ingress Helm release"
}

# Output the NGINX Ingress service URL (using the LoadBalancer IP)
output "nginx_ingress_service_url" {
  value       = "http://${kubernetes_service.nginx_ingress_controller.load_balancer_ingress[0].ip}/"
  description = "The URL of the NGINX Ingress service (LoadBalancer IP)"
}
