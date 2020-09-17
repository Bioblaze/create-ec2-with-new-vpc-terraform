locals {
    region = var.region
    project = var.project
    env = var.env
    tags = {
        Environment = "${var.env}"
        Project     = "${var.project}"
    }
    instance_type = var.instance_type
    cidr_block = var.cidr_block
    key_file = var.key_file
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = local.region
}

resource "aws_vpc" "ec2_vpc" {
  cidr_block = local.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = local.tags
}

resource "aws_subnet" "ec2_subnet" {
  vpc_id            = aws_vpc.ec2_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.ec2_vpc.cidr_block, 4, 1)
  map_public_ip_on_launch = true
  tags = local.tags
}

resource "aws_internet_gateway" "ec2_gateway" {
  vpc_id = aws_vpc.ec2_vpc.id
  tags = local.tags
}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"
  vpc_id = aws_vpc.ec2_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.ec2_vpc.cidr_block] To allow from VPC instead of Public
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.ec2_vpc.cidr_block] To allow from VPC instead of Public
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.ec2_vpc.cidr_block] To allow from VPC instead of Public
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # [aws_vpc.ec2_vpc.cidr_block] To allow from VPC instead of Public
  }

  tags = local.tags
}

data "aws_ami" "ec2_os_ami" {
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

resource "aws_route_table" "ec2_route_table" {
    vpc_id = aws_vpc.ec2_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ec2_gateway.id
    }
    tags = local.tags
}

resource "aws_route_table_association" "ec2_route_association" {
    subnet_id = aws_subnet.ec2_subnet.id
    route_table_id = aws_route_table.ec2_route_table.id
}

resource "aws_key_pair" "ec2_key" {
    key_name = "${local.project}-${local.env}-key"
    public_key = file(local.key_file)
    tags = local.tags
}

resource "aws_instance" "ec2_instance" {
    instance_type = local.instance_type
    ami = data.aws_ami.ec2_os_ami.id
    subnet_id = aws_subnet.ec2_subnet.id
    vpc_security_group_ids = [
        aws_security_group.ec2_security_group.id
    ]
    key_name = aws_key_pair.ec2_key.key_name
    tags = local.tags
}