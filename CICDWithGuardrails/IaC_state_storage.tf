## This is state storage for IaC state only. It doesn't store state for the CICD pipeline infrastructure
resource "google_storage_bucket" "default" {
  name          = var.iac_state_bucket_name
  # For real workloads, set this to false to prevent destruction and retain version control history of state files
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}