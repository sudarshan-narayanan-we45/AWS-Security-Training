resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "we45-aws-test-vpc-${random_string.random_name.result}"
  }
}
