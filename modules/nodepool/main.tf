resource "google_container_node_pool" "node_pool" {
  name       = var.node_pool_name
  cluster    = var.cluster_name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    preemptible  = var.preemptible

    # Disable external IP for node pool
    network_interface {
      network = var.network_id
      subnetwork = var.subnet_id
      access_config {
        # Disable external IP
        nat_ip = null
      }
    }
  }
  # Node management options
  management {
    auto_upgrade = true  # Automatically upgrade nodes to the latest GKE version
    auto_repair  = true  # Automatically repair unhealthy nodes
  }
}
