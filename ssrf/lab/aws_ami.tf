# data "aws_ami" "amz_linux" {
#   most_recent = true
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
