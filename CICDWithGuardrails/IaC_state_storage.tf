## This is state storage for IaC state only. It doesn't store state for the CICD pipeline infrastructure
resource "google_storage_bucket" "default" {
  name          = var.iac_state_bucket_name
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}