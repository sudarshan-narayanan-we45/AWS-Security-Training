resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "upload-bucket" {
  bucket = "${random_string.bucket_name.result}-uploads"
}

resource "aws_iam_group_membership" "team" {
  name = "upload-testing-group-membership"

  users = [
    "${aws_iam_user.user_one.name}",
  ]

  group = "${aws_iam_group.group.name}"
}

resource "aws_iam_group" "group" {
  name = "${random_string.bucket_name.result}-uploads-test-group"
}

resource "aws_iam_user" "user_one" {
  name = "${random_string.bucket_name.result}-uploads-test-user"
}

resource "aws_iam_policy" "policy" {
  name        = "${random_string.bucket_name.result}-uploads-policy"
  path        = "/"
  description = "${random_string.bucket_name.result}-uploads"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutItem"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.upload-bucket.arn}"
    }
  ]
}
EOF
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = "${aws_iam_group.group.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
