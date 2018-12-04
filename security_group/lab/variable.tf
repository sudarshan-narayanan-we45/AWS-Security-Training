variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "ami" {
  description = "Ubuntu 14.04"
  default = "ami-23a48cc8"
}


variable "key_name" {
  default = "security_group.pem"
}
