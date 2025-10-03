output "function_url" {
  value = google_cloudfunctions_function.api_function.https_trigger_url
}