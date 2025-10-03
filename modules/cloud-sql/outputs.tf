output "connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

output "database_name" {
  value = google_sql_database.database.name
}

output "db_user" {
  value = google_sql_user.user.name
}