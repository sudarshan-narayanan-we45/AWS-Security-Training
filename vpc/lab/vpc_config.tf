resource "random_string" "random_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "we45-VPC-${random_string.random_name.result}"
  }
}
