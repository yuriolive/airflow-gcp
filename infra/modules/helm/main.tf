data "google_client_config" "current" {}

provider "helm" {
  tiller_image = "gcr.io/kubernetes-helm/tiller:${var.helm_version}"

  # Enable TLS so Helm can communicate with Tiller securely.
  enable_tls = true

  kubernetes {
    host                   = var.gcp_gke_cluster_endpoint
    token                  = data.google_client_config.current.access_token
    client_certificate     = var.gcp_gke_cluster_client_certificate
    client_key             = var.gcp_gke_cluster_client_key
    cluster_ca_certificate = var.gcp_gke_cluster_ca_certificate
  }
}

resource "helm_release" "airflow" {
  name      = "airflow"
  chart     = "${path.module}/${helm_release.airflow.name}"

 /* set {
    name  = "mariadbUser"
    value = "foo"
  }

  set {
    name = "mariadbPassword"
    value = "qux"
  }*/

  provisioner "local-exec" {
    command = "helm test ${helm_release.airflow.name}"
  }
}