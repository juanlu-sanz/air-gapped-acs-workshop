# main.tf
# Purpose: Provision two ROSA HCP clusters on AWS for the ACS workshop

# Networking for hub cluster
module "hub_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_prefix}-hub-vpc"
  cidr = "10.0.0.0/16"

  azs             = var.availability_zones
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Networking for secured cluster
module "secured_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_prefix}-secured-vpc"
  cidr = "10.1.0.0/16"

  azs             = var.availability_zones
  private_subnets = ["10.1.1.0/24"]
  public_subnets  = ["10.1.101.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# ROSA HCP cluster: hub
resource "rhcs_cluster_rosa_hcp" "hub" {
  name                = "${var.cluster_prefix}-hub"
  version             = var.ocp_version
  cloud_region        = var.aws_region
  availability_zones  = var.availability_zones
  replicas            = var.hub_compute_nodes
  compute_machine_type = var.compute_machine_type

  aws_subnet_ids = concat(
    module.hub_vpc.private_subnets,
    module.hub_vpc.public_subnets
  )

  sts = {
    enabled = true
    auto_mode = true
  }

  wait_for_create_complete     = true
  wait_for_std_compute_nodes_complete = true
}

# ROSA HCP cluster: secured
resource "rhcs_cluster_rosa_hcp" "secured" {
  name                = "${var.cluster_prefix}-secured"
  version             = var.ocp_version
  cloud_region        = var.aws_region
  availability_zones  = var.availability_zones
  replicas            = var.secured_compute_nodes
  compute_machine_type = var.compute_machine_type

  aws_subnet_ids = concat(
    module.secured_vpc.private_subnets,
    module.secured_vpc.public_subnets
  )

  sts = {
    enabled = true
    auto_mode = true
  }

  wait_for_create_complete     = true
  wait_for_std_compute_nodes_complete = true
}
