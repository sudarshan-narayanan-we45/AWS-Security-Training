resource "random_string" "random_name" {
  length = 10
  special = false
  upper = false
}

resource "tls_private_key" "we45_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh" {
  key_name   = "we45_vpc_flow_log"
  public_key = "${tls_private_key.we45_test_key.public_key_openssh}"
}

resource "aws_subnet" "public-subnet" {
  cidr_block = "${var.public_subnet_cidr}"
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Public Subnet-${random_string.random_name.result}"
  }
}

resource "aws_route_table_association" "public-subnet" {
  route_table_id = "${aws_route_table.public-route.id}"
  subnet_id = "${aws_subnet.public-subnet.id}"
}



resource "aws_instance" "web" {
  ami                    = "ami-2757f631"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.ssh.key_name}"
  vpc_security_group_ids = [ "${aws_security_group.securtiy_group.id}" ]
  subnet_id = "${aws_subnet.public-subnet.id}"
  associate_public_ip_address = true
  source_dest_check = false

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${tls_private_key.we45_test_key.private_key_pem}"
      timeout = "5m"
      agent = true
    }

    inline = [
      "sudo apt-get update -y && apt-get upgrade -y",
      "sudo apt-get install nginx -y"
    ]
  }
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.we45_test_key.private_key_pem}"
  filename = "we45_vpc_flow_log.pem"
}

output "web_public_dns" {
  value = "${aws_instance.web.public_dns}"
}
