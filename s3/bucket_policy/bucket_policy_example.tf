resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "policy_bucket" {
  bucket = "${random_string.bucket_name.result}-policy-bucket"
}

variable "public_host" {}

resource "aws_s3_bucket_policy" "policy" {
  bucket = "${aws_s3_bucket.policy_bucket.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "BUCKETIPPOLICY",
  "Statement": [
      {
        "Sid": "IPAllow",
        "Effect": "Allow",
        "Principal": {"AWS": "*"},
        "Action": "s3:*",
        "Resource": [
          "arn:aws:s3:::${aws_s3_bucket.policy_bucket.bucket}",
          "arn:aws:s3:::${aws_s3_bucket.policy_bucket.bucket}/*"
        ],
        "Condition": {
           "IpAddress": {"aws:SourceIp": "${var.public_host}/32"}
        }
      }
  ]
}
POLICY
}