variable "aws_region" { }
variable "aws_profile" { }
variable "bucket_name" {}
variable "environment" { }
variable "app_name" {}
variable "ecr_repository_url" {}
variable "image_tag" {}
variable "aws_lb_target_group_arn" { }

variable "public_subnets" { 
  type = set(string)
}
variable "security_group_id" { }
variable "service_security_group" { }

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "1"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 5000
}

locals {
  app_image = format("%s:%s", var.ecr_repository_url, var.image_tag)
}