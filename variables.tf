variable "env" {
    description = "Development? Staging? Production? Dinosaur?"
    type = string
    default = "demonstration"
}

variable "project" {
    description = "This is so we can check the Tags to match this places."
    type = string
    default = "ec2_server_demo"
}

variable "region" {
    description = "Region that we will use on AWS"
    type = string
    default = "us-west-1"
}

variable "instance_type" {
    description = "How much Money do you want to spend? A.K.A. EC2 Instance Size?"
    type = string
    default = "t2.micro"
}

variable "key_file" {
    description = "How much Money do you want to spend? A.K.A. EC2 Instance Size?"
    type = string
    default = "key_file"
}

variable "cidr_block" {
    description = "Base CIDR Block to use for VPC"
    type = string
    default = "10.0.0.0/16"
}