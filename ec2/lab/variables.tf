variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ami" {
  description = "Ubuntu 14.04"
  default = "ami-23a48cc8"
}


variable "key_name" {}

variable "vpc_flow_iam_role" {
  default = "flowlogsRole"
}

variable "vpc_flow_cloud_watch_group" {
  default = "aws-vpc-flow-log"
}

variable "DnsZoneName" {
  default = "test.internal"
  description = "the internal dns name"
}
