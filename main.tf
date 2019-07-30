terraform {
  required_version = "~> 0.12"
}

module "backend" {
  source = "./modules/backend"
  environment = var.environment
  gcp_region = var.gcp_region
  gcp_cluster_name = var.gcp_cluster_name
}

module "cloudsql" {
  source = "./modules/cloudsql"
  gcp_region = var.gcp_region
  gcp_cloudsql_db_charset = var.gcp_cloudsql_db_charset
  gcp_cloudsql_db_collation = var.gcp_cloudsql_db_collation
  gcp_cloudsql_db_name = var.gcp_cloudsql_db_name
  gcp_cloudsql_name = var.gcp_cloudsql_name
  gcp_cloudsql_tier = var.gcp_cloudsql_tier
  gcp_cloudsql_backup_start_time = var.gcp_cloudsql_backup_start_time
  gcp_cloudsql_authorized_networks = ""
  gcp_cloudsql_disk_size = var.gcp_cloudsql_disk_size
  gcp_cloudsql_disk_type = var.gcp_cloudsql_disk_type
  gcp_cloudsql_maintenace_day = var.gcp_cloudsql_maintenace_day
  gcp_cloudsql_maintenace_hour = var.gcp_cloudsql_maintenace_hour
  gcp_sql_replica_zone = ""
  gcp_vpc_self_link = ""
}

module "gke" {
  source = "./modules/gke"
  environment = var.environment
  gcp_region = var.gcp_region
  gcp_cluster_name = var.gcp_cluster_name
}

module "helm" {
  source = "./modules/helm"
  environment = var.environment
  gcp_cluster_name = var.gcp_cluster_name
}
