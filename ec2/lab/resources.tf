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

resource "aws_instance" "db" {
  ami = "${data.aws_ami.ubuntu.id}"
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
  user_data = <<HEREDOC
  #!/bin/bash
  ###############################################
  echo "*****************************************"
  echo " 1. Prerequisites: Install updates, set time zones, install GCC and make"
  echo "*****************************************"
  #sudo yum -y update
  #sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles \/etc/localtime
  #sudo yum -y install gcc gcc-c++ make
  echo "*****************************************"
  echo " 2. Download, Untar and Make Redis 2.6"
  echo "*****************************************"
  cd /usr/local/src
  sudo wget http://redis.googlecode.com/files/redis-2.4.16.tar.gz
  sudo tar xzf redis-2.4.16.tar.gz
  sudo rm redis-2.4.16.tar.gz -f
  cd redis-2.4.16
  sudo make
  echo "*****************************************"
  echo " 3. Create Directories and Copy Redis Files"
  echo "*****************************************"
  sudo mkdir /etc/redis /var/lib/redis
  sudo cp src/redis-server src/redis-cli /usr/local/bin
  echo "*****************************************"
  echo " 4. Configure Redis.Conf"
  echo "*****************************************"
  echo " Edit redis.conf as follows:"
  echo " 1: ... daemonize yes"
  echo " 2: ... bind 127.0.0.1"
  echo " 3: ... dir /var/lib/redis"
  echo " 4: ... loglevel notice"
  echo " 5: ... logfile /var/log/redis.log"
  echo "*****************************************"
  sudo sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis.log/" redis.conf > /etc/redis/redis.conf
  echo "*****************************************"
  echo " 5. Download init Script"
  echo "*****************************************"
  wget https://raw.github.com/gist/3521590/e64b4b8ad7d38676f7e7f70b24f3f004b4f10b74/redis-server
  echo "*****************************************"
  echo " 6. Move and Configure Redis-Server"
  echo "*****************************************"
  sudo mv redis-server /etc/init.d
  sudo chmod 755 /etc/init.d/redis-server
  echo "*****************************************"
  echo " 7. Auto-Enable Redis-Server"
  echo "*****************************************"
  sudo chkconfig --add redis-server
  sudo chkconfig --level 345 redis-server on
  echo "*****************************************"
  echo " 8. Start Redis Server"
  echo "*****************************************"
  sudo service redis-server start
  echo "*****************************************"
  echo " Complete!"
  echo " You can test your redis installation using the redis console:"
  echo "   $ src/redis-cli"
  echo "   redis> set foo bar"
  echo "   OK"
  echo "   redis> get foo"
  echo "   bar"
  echo "*****************************************"
  read -p "Press [Enter] to continue..."
HEREDOC
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
    source = "AWS-VPC/helloworld"
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
