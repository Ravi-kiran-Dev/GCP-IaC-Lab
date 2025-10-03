resource "google_sql_database_instance" "instance" {
  name             = "${var.environment}-postgres-instance"
  database_version = "POSTGRES_13"
  project          = var.project_id
  region           = var.region

  settings {
    tier = var.tier

    backup_configuration {
      enabled            = true
      point_in_time_recovery_enabled = true
      start_time         = "03:00"
    }

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"
      }
    }

    location_preference {
      zone = "${var.region}-a"
    }

    database_flags {
      name  = "log_connections"
      value = "on"
    }
  }
deletion_protection = false
}

resource "google_sql_database" "database" {
  name     = "${var.environment}_app_db"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

resource "google_sql_user" "user" {
  name     = "${var.environment}_app_user"
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
  password = random_password.db_password.result
}

resource "random_password" "db_password" {
  length  = 16
  special = true
}