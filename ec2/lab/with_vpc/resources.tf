# Define SSH key pair for our instances

resource "random_string" "random_name" {
  length = 10
  special = false
  upper = false
}

resource "tls_private_key" "we45_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}--${random_string.random_name.result}"
  public_key = "${tls_private_key.we45_test_key.public_key_openssh}"
}



resource "aws_instance" "bastion_host" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.internet_ssh.id}"]
  associate_public_ip_address = true
  tags {
    Name = "bastion-host-${random_string.random_name.result}"
  }
  depends_on = [
    "aws_subnet.public-subnet",
    "aws_security_group.internet_ssh"
  ]


}

resource "aws_instance" "db" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = [
    "${aws_security_group.public_private_redis_ssh.id}",
    "${aws_security_group.private_egress_http_https.id}"
  ]
  source_dest_check = false
  associate_public_ip_address = false

  tags {
    Name = "redis-db-${random_string.random_name.result}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    agent = false
    private_key = "${tls_private_key.we45_test_key.private_key_pem}"
    timeout = "10m"
    bastion_host = "${aws_instance.bastion_host.public_ip}"
    bastion_user = "ec2-user"
    bastion_private_key = "${tls_private_key.we45_test_key.private_key_pem}"
  }
  provisioner "file" {
    source = "redis.conf"
    destination = "/tmp/redis.conf"
  }
  provisioner "file" {
    source = "install_redis.sh"
    destination = "/tmp/install_redis.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_redis.sh",
      "/tmp/install_redis.sh"
    ]
  }

  depends_on = [
    "aws_instance.bastion_host",
    "aws_subnet.public-subnet",
    "aws_subnet.private-subnet",
    "aws_security_group.public_private_redis_ssh",
    "aws_security_group.private_egress_http_https"
  ]
}

resource "aws_instance" "wb" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.internet_http.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  tags {
    Name = "flask-app-${random_string.random_name.result}"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    agent = false
    private_key = "${tls_private_key.we45_test_key.private_key_pem}"
    timeout = "10m"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sh -c 'echo \"APP_HOST=${aws_instance.db.private_ip}\" >> /etc/environment'",
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }

  depends_on = ["aws_instance.db"]

}
