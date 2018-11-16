resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "public_bucket" {
  bucket = "${random_string.bucket_name.result}-bucket.we45.com"
  acl = "public-read"
}