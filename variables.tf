variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "itm"
}

# VPC CIDR Block
variable "vpc_cidr" {
  default = "192.168.0.0/24"
}

variable "subnet_1_cidr" {
  default = "192.168.0.0/26"
}

variable "subnet_2_cidr" {
  default = "192.168.0.64/26"
}

variable "subnet_3_cidr" {
  default = "192.168.0.128/26"
}

variable "subnet_4_cidr" {
  default = "192.168.0.192/26"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ami_microservice" {
  default = "ami-0230bd60aa48260c6" // Amazon Linux 2023.2.20231113.0 x86_64
}