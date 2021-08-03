terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

resource "aws_vpc" "ec2_vpc" {
  cidr_block = "10.101.0.0/16"

  tags = {
    Name = "ec2_vpc"
  }
}

resource "aws_subnet" "ec2_subnet-1a" {
  vpc_id = aws_vpc.ec2_vpc.id
  cidr_block = "10.101.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "ec2_subnet-1a"
  }
}

resource "aws_network_interface" "primary_ec2_ni" {
  subnet_id = aws_subnet.ec2_subnet-1a.id
  private_ips = ["10.101.1.10"]

  tags = {
    Name = "primary_network_interface"
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04db49c0fb2215364"
  instance_type = "t2.micro"
  
  network_interface {
    network_interface_id = aws_network_interface.primary_ec2_ni.id
    device_index = 0
  }
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
