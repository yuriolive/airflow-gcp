/*

token                  = "${data.google_client_config.current.access_token}"


*/

output "gcp_gke_cluster_endpoint" {
  value = google_container_cluster.cluster.endpoint
}

output "gcp_gke_cluster_client_certificate" {
  value = base64decode(google_container_cluster.cluster.master_auth.0.client_certificate)
}

output "gcp_gke_cluster_client_key" {
  value = base64decode(google_container_cluster.cluster.master_auth.0.client_key)
}

output "gcp_gke_cluster_ca_certificate" {
  value = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
}