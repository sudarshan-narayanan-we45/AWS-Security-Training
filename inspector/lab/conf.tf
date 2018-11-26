provider "aws" {
  region     = "us-east-1"
}

resource "tls_private_key" "ucsf_inspector_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ucsf_aws_inspector"
  public_key = "${tls_private_key.ucsf_inspector_key.public_key_openssh}"
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.ucsf_inspector_key.private_key_pem}"
  filename = "aws_inspector_test.pem"
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow all ssh traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_inspector_resource_group" "test-group" {
  tags {
    Name = "${aws_instance.inspector.tags.Name}"
    Env  = "test-group"
  }
}

resource "aws_inspector_assessment_target" "test-target" {
  name = "inspector-assessment"
  resource_group_arn = "${aws_inspector_resource_group.test-group.arn}"
}

resource "aws_inspector_assessment_template" "test-template" {
  name       = "test-template"
  target_arn = "${aws_inspector_assessment_target.test-target.arn}"
  duration   = 3600

  rules_package_arns = [
    "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd",
  ]
}


resource "aws_instance" "inspector" {

  tags {
    Name = "aws-inspector-instance"
  }

  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name   = "${aws_key_pair.generated_key.key_name}"
  security_groups = [
  	"${aws_security_group.allow_ssh.name}"
  ]

  provisioner "remote-exec" {
  	connection {
  		type = "ssh"
  		user = "ubuntu"
  		private_key = "${tls_private_key.ucsf_inspector_key.private_key_pem}"
  		host = "${aws_instance.inspector.public_ip}"
  	}
  	inline = [
  		"cd /tmp && curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install",
      "sudo bash /tmp/install",
  	]
  }
}










