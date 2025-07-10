variable "region" { default = "eu-north-1" }
variable "cluster_name" { default = "rails-eks-cluster" }
variable "node_count" { default = 2 }
variable "instance_type" { default = "t3.medium" }
variable "db_username" { default = "railsuser" }
variable "db_password" { type = string }
variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

