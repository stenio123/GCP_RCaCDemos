## This file describes example infrastructure that will run in CICD



### Replace with your desired GCP infrastructure
## Assume project and network exist to segment infrastructure that meets compliance requirements
data "google_project" "my_project" {
    project_id = var.project_id
}

data "google_compute_network" "my_network" {
  name = var.network_name
  project = data.google_project.my_project.number
}

## Simple VM. 
resource "google_service_account" "default" {
  account_id   = "vm-service-account"
  display_name = "Service Account"
}

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
    network = data.google_compute_network.my_network.id
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}