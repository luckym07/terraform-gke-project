resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false  # Custom subnets
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = var.cidr_block
  private_ip_google_access = true         #This will ensure that the subnet remains private.
}