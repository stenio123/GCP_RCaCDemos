## This file describes project variables

variable "project_id" {
  type = string
  default = "default"
  description = "Project that has resources meeting compliance requirements."
}

variable "network_name" {
  type = string
  default = "default"
  description = "Network that has resources meeting compliance requirements."
}