output "external_ip" {
  value = google_compute_global_address.external_ip.address
}

output "instance_group_manager" {
  value = google_compute_instance_group_manager.igm.name
}