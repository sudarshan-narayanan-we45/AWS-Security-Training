# Define SSH key pair for our instances

resource "tls_private_key" "ucsf_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.ucsf_test_key.public_key_openssh}"
}

//Define database inside the private subnet

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

resource "aws_instance" "bastion_host" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  tags {
    Name = "bastion-host"
  }

}

resource "aws_instance" "db" {
  ami = "${data.aws_ami.amz_linux.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgdb.id}"]
  source_dest_check = false
  associate_public_ip_address = false
  iam_instance_profile = "${aws_iam_instance_profile.ec2_ssm_profile.name}"

  tags {
    Name = "redis-db"
  }
  connection {
    type = "ssh"
    host = "${aws_instance.bastion_host.public_ip}"
    user = "ec2-user"
    agent = false
    private_key = "${tls_private_key.ucsf_test_key.private_key_pem}"
    timeout = "10m"
  }
  provisioner "file" {
    source = "redis.conf"
    destination = "/tmp/redis.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum-config-manager --enable epel",
      "sudo yum install -y redis",
      "sudo rm /etc/redis.conf",
      "sudo mv /tmp/redis.conf /etc/redis.conf",
      "sudo redis-server &>/dev/null",
    ]
  }

  depends_on = ["aws_instance.bastion_host"]
}


//Define webserver inside the public subnet

resource "aws_instance" "wb" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t1.micro"
  key_name = "${aws_key_pair.generated_key.key_name}"
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  iam_instance_profile = "${aws_iam_instance_profile.ec2_ssm_profile.name}"
  tags {
    Name = "flask-app"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    agent = false
    private_key = "${tls_private_key.ucsf_test_key.private_key_pem}"
    timeout = "10m"
  }

  provisioner "file" {
    source = "/Users/tilakt/Documents/projects/UCSF/AWS-Security-Training/ec2/lab/helloworld"
    destination = "helloworld"
//    inline = [
//      "echo 'hi' >> test.txt",
//      "echo 'hi' >> /tmp/test.txt",
//    ]
  }
  provisioner "remote-exec" {
//    source = "/Users/tilakt/Documents/projects/terraform_aws/AWS-VPC/conf.d"
//    destination = "/etc/nginx/conf.d"
    inline = [
      "export db_ip=${aws_instance.db.private_dns}",
      "chmod +x /home/ubuntu/helloworld/script.sh",
      "sudo /home/ubuntu/helloworld/script.sh",
    ]
  }

  depends_on = ["aws_instance.db"]

}

//data "aws_ssm_parameter" "private_ip_db" {
//  name = "db_private_ip"
//  value = "${aws_instance.db.private_ip}"
//}


resource "aws_flow_log" "aws_vpc_flow_log" {
  iam_role_arn = "${aws_iam_role.vpc_flow_iam_role.arn}"
  log_destination = "${aws_cloudwatch_log_group.vpc_flow_cloud_watch_group.arn}"
  traffic_type = "ALL",
  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_cloudwatch_log_group" "vpc_flow_cloud_watch_group" {
  name = "aws-vpc-flow-log"
}

resource "aws_iam_role" "vpc_flow_iam_role" {
  name = "flowlogsRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "flowlogsRolePolicy"
  role = "${aws_iam_role.vpc_flow_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


