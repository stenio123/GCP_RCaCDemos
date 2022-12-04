## This file describes example infrastructure that will run in CICD


terraform {
 backend "gcs" {
   bucket  = "rcacdemo-bucket-tfstate"
   prefix  = "terraform/state"
 }
}

### Replace with your desired GCP infrastructure
provider "google" {
  project = var.project_id
  region  = "us-central1"
}

## Simple VM. 
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  confidential_instance_config {
    enable_confidential_compute = true
  }
  scheduling {
    on_host_maintenance = "TERMINATE"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private-subnetwork.id
  }

}


resource "google_compute_subnetwork" "private-subnetwork" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.custom-test.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "custom-test" {
  name                    = "test-network"
  auto_create_subnetworks = false
}
