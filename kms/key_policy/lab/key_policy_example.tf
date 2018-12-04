resource "aws_kms_key" "test_key" {
  description = "This is a test key that has a policy attached to it"
  is_enabled  = true
  enable_key_rotation = true
  tags {
    Name = "Test Key with Policy"
  }
}

data "aws_iam_policy_document" "appkeypolicy" {
  "statement" {
    sid = "1"
    actions = [
      "kms:*"
    ]
    resources = [
      "${aws_kms_key.test_key.arn}"
    ]
  }
}

resource "aws_iam_policy" "ApplicationKeyPolicy" {
  policy = "${data.aws_iam_policy_document.appkeypolicy.json}"
}

resource "aws_iam_role" "app_key_role" {
  name = "app-key-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "AppKeyRolePolicy" {
  name = "appkey role policy attachment"
  roles = ["${aws_iam_role.app_key_role.name}"]
  policy_arn = "${aws_iam_policy.ApplicationKeyPolicy.arn}"
}