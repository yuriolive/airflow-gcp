# https://www.terraform.io/docs/providers/google/r/compute_network.html
resource "google_compute_network" "private_network" {
  name = var.gcp_private_network_name
  auto_create_subnetworks = false
}