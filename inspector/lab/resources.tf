provider "aws" {
  region     = "us-east-1"
}

resource "tls_private_key" "inspector_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "aws_inspector"
  public_key = "${tls_private_key.inspector_key.public_key_openssh}"
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.inspector_key.private_key_pem}"
  filename = "aws_inspector_test.pem"
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
  		private_key = "${tls_private_key.inspector_key.private_key_pem}"
  		host = "${aws_instance.inspector.public_ip}"
  	}
  	inline = [
  		"cd /tmp && curl -O https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install",
        "sudo bash /tmp/install",
  	]
  }
}










