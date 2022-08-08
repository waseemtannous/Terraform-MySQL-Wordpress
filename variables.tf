variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.100.0.0/16"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.100.1.0/24"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.100.2.0/24"
}

variable "availability_zone" {
  type    = string
  default = "eu-central-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_ami" {
  type    = string
  default = "ami-065deacbcaac64cf2" # eu-central-1
}
