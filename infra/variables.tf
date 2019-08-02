variable "gcp_region" {
  default = "us-central1"
}

variable "gcp_project_id" {
  type = "string"
  description = "The ID of the associated project."
}

variable "gcp_private_network_name" {
  type = "string"
  description = "The project private network name."
}

variable "gcp_cluster_name" {
  type = "string"
  description = "The GKE cluster name."
}

variable "gcp_node_pool_name" {
  type = "string"
  description = "The GKE node pool name."
}


# ---------------------------------------------------------------------------------------------------------------------
# CLOUDSQL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------
variable "gcp_cloudsql_name" {
  type = "string"
  description = "The CloudSQL instance name."
}

variable "gcp_cloudsql_db_name" {
  type = "string"
  description = "The CloudSQL database name."
}

variable "gcp_cloudsql_tier" {
  type = "string"
  description = "The CloudSQL database tier."
}

variable "gcp_coudlsql_backup_start_time" {
  type = "string"
}

variable "gcp_cloudsql_db_charset" {
  type = "string"
}

variable "gcp_cloudsql_db_collation" {
  type = "string"
}