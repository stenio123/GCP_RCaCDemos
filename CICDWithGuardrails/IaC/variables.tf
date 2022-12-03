## This file describes project variables

variable "project_id" {
  type = string
  default = "home-330415"
  description = "Project that will have resources meeting compliance requirements."
}

variable "iac_state_bucket_name" {
  type = string
  default = "rcacdemo-bucket-tfstate"
  description = "Project that will have resources meeting compliance requirements."
}