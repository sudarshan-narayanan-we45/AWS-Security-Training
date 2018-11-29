resource "aws_key_pair" "hostkey" {
  public_key = "${file(var.PUB_KEY)}"
}

resource "aws_security_group" "host_security_group" {
  name = "ucsf group"
  description = "UCSF Group for Inbound Connections to limited ports"

  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amz_linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_instance" "ucsf-instance" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.hostkey.key_name}"
  security_groups = ["${aws_security_group.host_security_group.name}"]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = "${file("${var.PRIV_KEY}")}"
      host = "${aws_instance.ucsf-instance.public_ip}"
    }
    inline = [
      "sudo yum install nginx -y"
    ]
  }
}