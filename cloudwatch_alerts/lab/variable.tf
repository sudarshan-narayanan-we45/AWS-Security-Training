variable "bucket_prefix" {
  default = "ucsf-logs-trails"
}

variable "trail_name" {
  default = "ucsf-trail"
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
  default = "UCSFCloudTrailMetrics"
}


variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "ucsf_cloudwatch_alert"
}

