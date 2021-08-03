terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}


resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.101.0.0/16"

  tags = {
    Name = "ec2_vpc"
  }
}
