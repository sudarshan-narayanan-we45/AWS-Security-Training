resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "ec2-bucket" {
  bucket = "${random_string.bucket_name.result}-uploads"
}

resource "aws_s3_bucket_object" "hello_file" {
  bucket = "${aws_s3_bucket.ec2-bucket.bucket}"
  key = "hello.txt"
  source = "hello.txt"
}


resource "aws_iam_role_policy" "attach-policy" {
  role = "${aws_iam_role.tes_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.ec2-bucket.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_role" "tes_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = "${aws_iam_role.tes_role.name}"
}

output "aws_iam_role_profile_name" {
  value = "Role: ${aws_iam_role.tes_role.arn}, Profile: ${aws_iam_instance_profile.test_profile.arn}"
}

variable "key_name" {
  default = "we45_iam_role_policy"
}

# data "aws_ami" "amz_linux" {
#   most_recent = true
#   owners = ["self"]
#   filter {
#     name = "name"
#     values = ["amzn-ami-*-x86_64-gp2"]
#   }
#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
#   filter {
#     name = "owner-alias"
#     values = ["amazon"]
#   }
# }

resource "tls_private_key" "we45_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.we45_test_key.public_key_openssh}"
}

resource "local_file" "aws_key" {
  content = "${tls_private_key.we45_test_key.private_key_pem}"
  filename = "we45_iam_role_policy.pem"
}

resource "aws_security_group" "host_security_group" {
  name = "group"
  description = "Group for Inbound Connections to limited ports"

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



resource "aws_instance" "test-host" {
  ami = "ami-0c6b1d09930fac512"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  associate_public_ip_address = true
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  security_groups = ["${aws_security_group.host_security_group.name}"]

  tags {
    Name = "${random_string.bucket_name.result}-host"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    agent = false
    private_key = "${tls_private_key.we45_test_key.private_key_pem}"
    timeout = "10m"
  }
  provisioner "remote-exec" {
    inline = ["sudo aws s3 ls s3://${aws_s3_bucket.ec2-bucket.bucket}"]
  }
  depends_on = ["aws_iam_role.tes_role"]
}
