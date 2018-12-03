provider "aws" {
  region     = "us-east-1"
}

resource "tls_private_key" "test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "aws_lynis"
  public_key = "${tls_private_key.test_key.public_key_openssh}"
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.test_key.private_key_pem}"
  filename = "aws_test.pem"
}

resource "aws_instance" "web" {
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
  		private_key = "${tls_private_key.test_key.private_key_pem}"
  		host = "${aws_instance.web.public_ip}"
  	}
  	inline = [
      "sudo apt-get update && sudo apt install -y lynis && sudo lynis audit system --quick > /tmp/lynis-report.txt"
  	]
  }
  provisioner "local-exec" {
    command = "chmod 400 ${local_file.aws_key.filename} && scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${local_file.aws_key.filename} ubuntu@${aws_instance.web.public_ip}:/tmp/lynis-report.txt $(pwd)"
  }
}







