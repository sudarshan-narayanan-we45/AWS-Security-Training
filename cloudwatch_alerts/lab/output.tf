//for ssh we need privatekey output

resource "local_file" "aws_key" {
  content = "${tls_private_key.ucsf_test_key.private_key_pem}"
  filename = "ucsf_cloudwatch.pem"
}


output "connect_string" {
  value = "ssh -i ucsf_cloudwatch.pem ${var.instance_user}@${aws_instance.web_app.public_dns}"
}
