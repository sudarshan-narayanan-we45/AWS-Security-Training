variable "bucket_prefix" {
  default = "we45-log-cloudtrails"
}

variable "trail_name" {
  default = "we45-demo-cloud-trail"
}

variable "example_vpc_cidr" {
  default = "172.24.0.0/16"
}

variable "example_subnet_cidr" {
  default = "172.24.0.0/24"
}

variable "ami_name" {
  default = "amzn2-ami-hvm-2017.12.0.20180115-x86_64-gp2"
}

variable "root_vol_size" {
  default = 8
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_user" {
  default = "ec2-user"
}

variable "metric_name_space" {
  default = "we45-CloudTrailMetrics"
}


//variable "aws_region" {
//}

variable "key_name" {
  default = "we45_cloudwatch"
}

