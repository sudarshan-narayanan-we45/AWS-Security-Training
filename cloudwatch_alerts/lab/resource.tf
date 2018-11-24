
data "aws_ami" "target_ami" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }
}

resource "aws_instance" "web_app" {
  ami           = "${data.aws_ami.target_ami.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id     = "${aws_subnet.example.id}"

  vpc_security_group_ids = [
    "${aws_security_group.allow_ssh_access.id}",
    "${aws_security_group.http_out_access.id}",
  ]

  root_block_device = {
    volume_type = "gp2"
    volume_size = "${var.root_vol_size}"
  }
  tags {
    Name = "WebApp"
  }
  user_data = <<EOF
#!/bin/bash
yum update -y -q
yum erase -y -q ntp*
yum -y -q install chrony git
service chronyd start
EOF
}
