# Output for VPC ID
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

# Output for Subnet ID
output "subnet_id" {
  description = "The ID of the created subnet"
  value       = module.vpc.subnet_id
}

# Output for GKE Cluster Name
output "gke_cluster_name" {
  description = "The name of the GKE Cluster"
  value       = module.gke_cluster.gke_cluster_name
}

# Output for GKE Cluster Endpoint
output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE Cluster"
  value       = module.gke_cluster.gke_cluster_endpoint
}

# Output for Nodepool Name
output "node_pool_name" {
  description = "The name of the Node Pool"
  value       = module.nodepool.node_pool_name
}

# Output for NGINX Ingress URL
output "nginx_ingress_url" {
  description = "The URL of the NGINX Ingress"
  value       = module.nginx_ingress.ingress_url
}

# Output for the SSL Secret Name
output "ssl_secret_name" {
  description = "The name of the SSL Secret"
  value       = kubernetes_secret.ssl_cert.metadata[0].name
}

# Output for Backend Service Self Link
output "nginx_backend_service_self_link" {
  description = "The self link of the NGINX Backend Service"
  value       = module.nginx_backend_service.backend_service_self_link
}

# Output for NGINX Load Balancer IP
output "nginx_load_balancer_ip" {
  description = "The IP address of the NGINX Load Balancer"
  value       = module.nginx_load_balancer.ip_address
}
