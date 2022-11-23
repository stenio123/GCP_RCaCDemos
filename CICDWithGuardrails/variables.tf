## This file describes project variables

variable "project_id" {
  type = string
  default = "default"
  description = "Project that has resources meeting compliance requirements."
}

variable "services" {
  type = list(string)
  default = ["compute.googleapis.com",
             "storage-api.googleapis.com",
            "storage-component.googleapis.com",
            "storage.googleapis.com"]
    description = "Enable required APIs for this deployment"
}

variable "network_name" {
  type = string
  default = "default"
  description = "Network that has resources meeting compliance requirements."
}

variable "terraform_bucket_name" {
  type = string
  default = "terraform_state"
  description = "Object storage bucket where state will be stored. Created dynamically."
}

variable "terraform_bucket_location" {
    type = "string"
    default = "US-CENTRAL1"
}