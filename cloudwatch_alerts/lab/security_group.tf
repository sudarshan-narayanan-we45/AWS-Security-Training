//Settingup a security groups

resource "aws_default_security_group" "cloudwatch_default" {
  vpc_id = "${aws_vpc.cloudwatch_vpc.id}"
  tags {
    Name = "we45-Default-Group-${random_string.random_name.result}"
  }
}

resource "aws_security_group" "allow_ssh_access" {
  name        = "allow_ssh_access - ${random_string.random_name.result}"
  description = "allows ssh access to the app server"
  vpc_id      = "${aws_vpc.cloudwatch_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http_out_access" {
  name        = "allow-http-out - ${random_string.random_name.result}"
  description = "allows instance to open webapp"
  vpc_id      = "${aws_vpc.cloudwatch_vpc.id}"

  ingress {
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
