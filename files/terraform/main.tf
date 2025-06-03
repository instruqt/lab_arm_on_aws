terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
  region     = var.region
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#resource "aws_default_vpc" "default" {
#  tags = {
#    Name = "Default VPC"
#  }
#}

resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.rsa-4096.public_key_openssh
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t4g.micro"
  key_name      = aws_key_pair.deployer.key_name
  associate_public_ip_address = true
}

resource "local_file" "ssh_private_key" {
  content  = tls_private_key.rsa-4096.private_key_pem
  filename = "/tmp/ssh/id_rsa"
}

resource "local_file" "ssh_public_key" {
  content  = tls_private_key.rsa-4096.public_key_openssh
  filename = "/tmp/ssh/id_rsa.pub"
}