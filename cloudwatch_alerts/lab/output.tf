//for ssh we need privatekey output

output "private_key" {
  value = "${tls_private_key.ucsf_test_key.private_key_pem}"

}

output "connect_string" {
  value = "ssh -i ucsf_cloudwatch.pem ${var.instance_user}@${aws_instance.web_app.public_dns}"
}
