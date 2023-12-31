terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.vpc-subnet.id

  tags = {
    Name = "Hello"
  }
}

resource "aws_vpc" "net-vpc" {
  cidr_block = var.vpc-cidr
}

resource "aws_subnet" "vpc-subnet" {
  cidr_block = var.subnet-cidr
  vpc_id     = aws_vpc.net-vpc.id
}
