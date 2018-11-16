resource "aws_kms_key" "grant_key" {
  description = "This Key has a Grant assigned to it"
  is_enabled  = true
  tags {
    Name = "Key with Grant enabled"
  }
}

resource "random_string" "username" {
  length = 10
  special = false
  upper = false
}

resource "aws_iam_user" "testuser" {
  name = "${random_string.username.result}-user"
}

resource "aws_kms_grant" "hugh-grant" {
  grantee_principal = "${aws_iam_user.testuser.arn}"
  key_id = "${aws_kms_key.grant_key.key_id}"
  operations = ["Encrypt", "Decrypt", "GenerateDataKey"]
  constraints {
    encryption_context_equals {
      Department = "Finance"
    }
  }
}
