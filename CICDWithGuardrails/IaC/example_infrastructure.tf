## This file describes example infrastructure that will run in CICD

terraform {
 backend "gcs" {
   bucket  = var.iac_state_bucket_name
   prefix  = "terraform/state"
 }
}

### Replace with your desired GCP infrastructure
## Assume project and network exist to segment infrastructure that meets compliance requirements
data "google_project" "my_project" {
    project_id = var.project_id
}

## Simple VM. 
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = google_compute_subnetwork.private-subnetwork.id
  }

}


resource "google_compute_subnetwork" "private-subnetwork" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
  project = data.google_project.my_project.number
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
project = data.google_project.my_project.number
}
