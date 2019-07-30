variable "gcp_region" {
  type = "string"
}

variable "gcp_vpc_self_link" {
  type = "string"
}

variable "gcp_sql_replica_zone" {
  type = "string"
}

variable "gcp_cloudsql_tier" {
  type = "string"
}

variable "gcp_cloudsql_disk_type" {
  type = "string"
}

variable "gcp_cloudsql_disk_size" {
  type = "string"
}

variable "gcp_cloudsql_authorized_networks" {
  type = "list"
}

variable "gcp_cloudsql_maintenace_day" {
  type = "string"
}

variable "gcp_cloudsql_maintenace_hour" {
  type = "string"
}

variable "gcp_cloudsql_backup_start_time" {
  type = "string"
}

variable "gcp_cloudsql_db_name" {
  type = "string"
}

variable "gcp_cloudsql_db_charset" {
  type = "string"
}

variable "gcp_cloudsql_db_collation" {
  type = "string"
}