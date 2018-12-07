resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "negated-bucket" {
  bucket = "${random_string.bucket_name.result}-negated"
}

resource "aws_iam_policy" "policy" {
  name        = "${random_string.bucket_name.result}-negated-policy"
  path        = "/"
  description = "${random_string.bucket_name.result}-negated"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutItem"
      ],
      "Effect": "Allow",
      "NotResource": "${aws_s3_bucket.negated-bucket.arn}",
      "Condition": {
        "DateLessThan": {
         "aws:CurrentTime" : "2019-02-16T15:00:00Z"
       }
      }
    }
  ]
}
EOF
}