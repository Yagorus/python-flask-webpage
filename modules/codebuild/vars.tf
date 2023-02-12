variable "aws_region" { }       # 1
variable "aws_profile" { }      # 1
variable "environment" { }      # 1
variable "app_name" { }         # 1
variable "buildspec_path" {}    # 1
variable "buildspec_file" { }   # 1
variable "github_path_url" {}   # 1
variable "git_trigger" { }      # 1
variable "git_pattern_branch" {} #1
variable "token_git" {  }       # 1
variable "public_subnets" {}
variable "vpc_id" {}


variable "security_groups" {
  type        = list(string)
  default     = null
  description = "The security group IDs used by CodeBuild to allow access to resources in the VPC"
}


variable "cidr_blocks"{
  description = "Cidr block for codebuild security group "
  default = "0.0.0.0/0"
}