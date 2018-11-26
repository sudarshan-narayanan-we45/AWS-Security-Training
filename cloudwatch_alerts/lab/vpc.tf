//Setup VPC for ec2

resource "aws_vpc" "ucsf_cloudwatch_vpc" {
  cidr_block           = "${var.example_vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "ucsf_gateway" {
  vpc_id = "${aws_vpc.ucsf_cloudwatch_vpc.id}"
}

resource "aws_route_table" "ucsf_route" {
  vpc_id = "${aws_vpc.ucsf_cloudwatch_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ucsf_gateway.id}"
  }
}

resource "aws_route_table_association" "ucsf_route_table" {
  subnet_id      = "${aws_subnet.example.id}"
  route_table_id = "${aws_route_table.ucsf_route.id}"
}

resource "aws_subnet" "example" {
  vpc_id                  = "${aws_vpc.ucsf_cloudwatch_vpc.id}"
  cidr_block              = "${var.example_subnet_cidr}"
  map_public_ip_on_launch = true
}
