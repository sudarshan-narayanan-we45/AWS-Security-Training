//Creatingg on the fly sshkey for ec2 access

resource "tls_private_key" "we45_test_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.key_name}"
  public_key = "${tls_private_key.we45_test_key.public_key_openssh}"
}
