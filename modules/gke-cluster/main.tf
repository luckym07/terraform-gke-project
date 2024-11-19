resource "google_container_cluster" "gke" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = 1
  network            = var.network_id
  subnetwork         = var.subnet_id

  private_cluster_config {
    enable_private_nodes = true
    master_ipv4_cidr_block = var.master_cidr_block
  }

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  enable_private_endpoint = true
  enable_master_authorized_networks = true
}