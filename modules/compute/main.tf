resource "google_compute_instance_template" "instance_template" {
  name         = "${var.environment}-web-template"
  project      = var.project_id
  machine_type = "e2-micro"

  tags = ["http-server", "internal"]

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnet
    access_config {
      // Ephemeral IP
    }
  }

  # Use heredoc with proper line endings - this is the key fix
  metadata_startup_script = <<-"SCRIPT"
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx

    # Simple web server
    cat > /var/www/html/index.html << 'EOF'
    <html>
    <head><title>Multi-Tier App - ${var.environment}</title></head>
    <body>
    <h1>Multi-Tier Application</h1>
    <p>Environment: ${var.environment}</p>
    <p>Instance: $(hostname)</p>
    </body>
    </html>
    EOF
  SCRIPT

  service_account {
    email  = google_service_account.compute_sa.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "igm" {
  name        = "${var.environment}-web-igm"
  project     = var.project_id
  base_instance_name = "${var.environment}-web"
  zone        = var.zone

  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }

  target_size = var.instance_count

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http_check.id
    initial_delay_sec = 300
  }

  depends_on = [google_compute_instance_template.instance_template]
}

resource "google_compute_health_check" "http_check" {
  name   = "${var.environment}-http-health-check"
  project = var.project_id

  http_health_check {
    port = 80
  }
}

resource "google_compute_global_address" "external_ip" {
  name    = "${var.environment}-external-ip"
  project = var.project_id
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "${var.environment}-http-forwarding-rule"
  project    = var.project_id
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
  ip_address = google_compute_global_address.external_ip.address

  depends_on = [google_compute_backend_service.default]
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.environment}-target-proxy"
  project = var.project_id
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name    = "${var.environment}-url-map"
  project = var.project_id

  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name                  = "${var.environment}-backend-service"
  project               = var.project_id
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_instance_group_manager.igm.instance_group
  }

  health_checks = [google_compute_health_check.http_check.id]
}

resource "google_service_account" "compute_sa" {
  account_id   = "${var.environment}-compute-sa"
  display_name = "${var.environment} Compute Service Account"
  project      = var.project_id
}