## This file describes project variables

variable "iac_state_bucket_name" {
  type = string
  default = "RCaCDemo-bucket-tfstate"
  description = "Project that will have resources meeting compliance requirements."
}