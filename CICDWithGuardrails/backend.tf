## This file describes where terrform state will be stored

terraform {
  backend "gcs" {
    bucket = var.terraform_bucket
    prefix = "env/dev"
  }
}

resource "google_storage_bucket" "terraform_state" {
  name          = var.terraform_bucket_name + "_" + random_string.random
  location = var.terraform_bucket_location
}

resource "random_string" "random" {
  length           = 5
  special          = false
}