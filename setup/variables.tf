# variables.tf
# Purpose: Input variables for the workshop ROSA HCP cluster provisioning

variable "aws_region" {
  description = "AWS region for both clusters"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_prefix" {
  description = "Prefix for cluster names"
  type        = string
  default     = "acs-workshop"
}

variable "ocp_version" {
  description = "OpenShift version for ROSA HCP clusters"
  type        = string
  default     = "4.17.14"
}

variable "rosa_token" {
  description = "OCM token for ROSA authentication"
  type        = string
  sensitive   = true
}

variable "hub_compute_nodes" {
  description = "Number of compute nodes for the hub cluster"
  type        = number
  default     = 2
}

variable "secured_compute_nodes" {
  description = "Number of compute nodes for the secured cluster"
  type        = number
  default     = 2
}

variable "hub_compute_machine_type" {
  description = "EC2 instance type for hub cluster compute nodes (needs extra capacity for ACS Central)"
  type        = string
  default     = "m5.2xlarge"
}

variable "secured_compute_machine_type" {
  description = "EC2 instance type for secured cluster compute nodes"
  type        = string
  default     = "m5.xlarge"
}

variable "availability_zones" {
  description = "Availability zones for the clusters (single AZ keeps costs low for demos)"
  type        = list(string)
  default     = ["eu-west-1a"]
}

variable "aws_billing_account_id" {
  description = "AWS billing account ID for ROSA HCP clusters"
  type        = string
}

variable "tags" {
  description = "AWS tags applied to all resources"
  type        = map(string)
  default = {
    project     = "acs-workshop"
    environment = "demo"
    managed-by  = "terraform"
  }
}
