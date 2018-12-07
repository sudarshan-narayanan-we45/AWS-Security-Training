resource "random_string" "user_random" {
  length = 10
  special = false
  upper = false
}

resource "aws_iam_policy" "boundary_policy" {
  name        = "${random_string.user_random.result}-boundary-policy"
  path        = "/"
  description = "${random_string.user_random.result}-boundary-policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*",
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_iam_user" "user_one" {
  name = "${random_string.user_random.result}-test-user"
  permissions_boundary = "${aws_iam_policy.boundary_policy.arn}"
}