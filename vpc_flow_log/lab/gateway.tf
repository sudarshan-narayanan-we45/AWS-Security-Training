resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.default.id}"


  tags {
    Name = "VPC Gateway-${random_string.random_name.result}"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.default.id}"


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gateway.id}"

  }

  tags {
    Name = "Public Subnet Route-${random_string.random_name.result}"
  }
}
