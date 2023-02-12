variable "aws_region" { }
variable "aws_profile" { }
variable "environment" { }
variable "app_name" { }

variable "cidr_block_vpc" {
  default = "10.0.0.0/16"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}