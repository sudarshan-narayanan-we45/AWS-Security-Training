resource "aws_kms_key" "oauth_config" {
  description = "oauth config"
  is_enabled  = true
  enable_key_rotation = true
  tags {
    Name = "OAuth Key"
  }
}

data "aws_kms_ciphertext" "oauth" {
  key_id = "${aws_kms_key.oauth_config.key_id}"

  plaintext = <<EOF
{
  "client_id": "e587dbae22222f55da22",
  "client_secret": "8289575d00000ace55e1815ec13673955721b8a5"
}
EOF
}

output "ciphertext" {
  value = "${data.aws_kms_ciphertext.oauth.ciphertext_blob}"
}