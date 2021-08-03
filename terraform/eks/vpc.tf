provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  cluster_name = "eks_engaged"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name = "eks_vpc"
  cidr = "10.101.0.0/16"
  azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets = ["10.101.20.0/24", "10.101.30.0/24"]
  public_subnets = [ "10.101.10.0/24" ]
  enable_nat_gateway = false
  single_nat_gateway = false
  enable_dns_hostnames = true
}
