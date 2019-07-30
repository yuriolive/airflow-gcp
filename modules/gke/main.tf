provider "random" {}

resource "random_pet" "random_name" {}

# https://www.terraform.io/docs/providers/google/r/container_cluster.html
resource "google_container_cluster" "cluster" {
  name      = "gke-cluster-${terraform.workspace}-${random_pet.random_name.id}"
  location  = var.gcp_subnet_location

  # The number of nodes to create in this cluster (not including the Kubernetes master).
  initial_node_count = var.gcp_gke_num_nodes
  network            = var.gcp_vpc_name
  subnetwork         = var.gcp_subnet_name

  addons_config {
    kubernetes_dashboard {
      disabled = false
    }
  }

  master_auth {
    username = var.gcp_gke_master_user
    password = var.gcp_gke_master_pass
  }
}

# https://www.terraform.io/docs/providers/google/r/container_node_pool.html
resource "google_container_node_pool" "node_pool" {
  name      = "gke-pool-${terraform.workspace}-${random_pet.random_name.id}"
  location  = var.gcp_subnet_location
  cluster   = google_container_cluster.cluster.name

  node_config {
    preemptible = false
    machine_type = var.gcp_node_machine_type
    disk_size_gb = var.gcp_node_disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}