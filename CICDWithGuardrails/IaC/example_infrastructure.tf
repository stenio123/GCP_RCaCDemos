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
/**
## Simple VM. 
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  shielded_instance_config {
    enable_secure_boot = true
    enable_vtpm = true
    enable_integrity_monitoring = true
  }
  allow_stopping_for_update = true

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

resource "random_id" "id" {
	  byte_length = 4
}

resource "google_storage_bucket" "default" {
  name          = "rcac-demo-${random_id.id.hex}"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
}

resource "google_storage_bucket_acl" "image-store-acl" {
  bucket = google_storage_bucket.default.name

  predefined_acl = "private"
  #predefined_acl = "publicRead"
}*/