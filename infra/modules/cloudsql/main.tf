provider "random" {}

resource "random_pet" "random_name" {}

# https://www.terraform.io/docs/providers/google/r/sql_database_instance.html
resource "google_sql_database_instance" "master" {
  name = "sql-master-${terraform.workspace}-${random_pet.random_name.id}"
  database_version = "POSTGRES_9_6"
  region = var.gcp_region

  settings {
    tier            = var.gcp_cloudsql_tier
    disk_type       = var.gcp_cloudsql_disk_type
    disk_size       = var.gcp_cloudsql_disk_size
    disk_autoresize = true

    maintenance_window {
      day           = var.gcp_cloudsql_maintenace_day
      hour          = var.gcp_cloudsql_maintenace_hour
      update_track  = "stable"
    }

    ip_configuration {
      ipv4_enabled       = false
      private_network    = var.gcp_vpc_self_link
      require_ssl        = true
      authorized_networks = var.gcp_cloudsql_authorized_networks
    }

    backup_configuration {
      enabled            = true
      start_time         = var.gcp_cloudsql_backup_start_time
    }

    location_preference {
      zone = "${var.gcp_region}-${var.gcp_sql_replica_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_sql_database_instance" "failover" {
  depends_on = [
    "google_sql_database_instance.master",
  ]

  name                 = "sql-replica-${terraform.workspace}-${random_pet.random_name.id}"
  count                = terraform.workspace == "production" ? 1 : 0
  database_version     = "POSTGRES_9_6"
  region               = var.gcp_region
  master_instance_name = google_sql_database_instance.master.name

  replica_configuration {
    failover_target = true
  }

  settings {
    tier            = var.gcp_cloudsql_tier
    disk_type       = var.gcp_cloudsql_disk_type
    disk_size       = var.gcp_cloudsql_disk_size
    disk_autoresize = true

    maintenance_window {
      day           = var.gcp_cloudsql_maintenace_day
      hour          = var.gcp_cloudsql_maintenace_hour
      update_track  = "stable"
    }

    ip_configuration {
      ipv4_enabled       = false
      private_network    = var.gcp_vpc_self_link
      require_ssl        = true
      authorized_networks = var.gcp_cloudsql_authorized_networks
    }

    location_preference {
      zone = "${var.gcp_region}-${var.gcp_sql_replica_zone}"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# https://www.terraform.io/docs/providers/google/r/sql_database.html
resource "google_sql_database" "database" {
  name      = var.gcp_cloudsql_db_name
  instance  = google_sql_database_instance.master.name
  charset   = var.gcp_cloudsql_db_charset
  collation = var.gcp_cloudsql_db_collation
}

# https://www.terraform.io/docs/providers/google/r/sql_user.html
resource "google_sql_user" "users" {
  depends_on = [
    "google_sql_database_instance.master",
    "google_sql_database_instance.failover",
  ]

  instance = google_sql_database_instance.master.name
  host     = var.gcp_cloudsql_user_host
  name     = var.gcp_cloudsql_user_name
  password = var.gcp_cloudsql_user_password
}