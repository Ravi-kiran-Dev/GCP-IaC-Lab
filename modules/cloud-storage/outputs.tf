output "website_url" {
  value = "https://${google_storage_bucket.website.name}.storage.googleapis.com"
}