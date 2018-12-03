//for ssh we need privatekey output

resource "local_file" "aws_key" {
  content = "${tls_private_key.test_key.private_key_pem}"
  filename = "cloudwatch.pem"
}


output "connect_string" {
  value = "ssh -i cloudwatch.pem ${var.instance_user}@${aws_instance.web_app.public_dns}"
}
