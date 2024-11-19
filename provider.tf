# Google Cloud provider
provider "google" {
  project = var.PROJECT_ID
  region  = var.REGION
}

# Kubernetes provider
provider "kubernetes" {
  host                   = google_container_cluster.gke.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# Helm provider (if you're using Helm to deploy resources in Kubernetes)
provider "helm" {
  kubernetes {
    host                   = google_container_cluster.gke.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.gke.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

# Data source to get the client configuration (access token)
data "google_client_config" "default" {}

