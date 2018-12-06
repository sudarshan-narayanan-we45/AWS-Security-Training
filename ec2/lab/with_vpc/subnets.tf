resource "aws_subnet" "public-subnet" {
  cidr_block = "${var.public_subnet_cidr}"
  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Public Subnet - ${random_string.random_name.result}"
  }
}

resource "aws_route_table_association" "public-subnet" {
  route_table_id = "${aws_route_table.public-route.id}"
  subnet_id = "${aws_subnet.public-subnet.id}"
}

resource "aws_subnet" "private-subnet" {
  cidr_block = "${var.private_subnet_cidr}"
  vpc_id = "${aws_vpc.stack-example-vpc.id}"

  tags {
    Name = "Private Subnet - ${random_string.random_name.result}"
  }
}

resource "aws_route_table_association" "private-subnet" {
    subnet_id = "${aws_subnet.private-subnet.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}


