resource "random_string" "log-bucket" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "logs" {
  bucket = "${random_string.log-bucket.result}-site-logs"
  acl = "log-delivery-write"
  force_destroy = true
}

resource "aws_s3_bucket" "static_app" {
  acl    = "public-read"
  force_destroy = true
  bucket = "${random_string.log-bucket.result}-static"

  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "we45-${random_string.log-bucket.result}/"
  }

  website {
    index_document = "index.html"
    error_document = "index.html"

  }
  depends_on = ["aws_s3_bucket.logs"]
}

resource "aws_s3_bucket_object" "aws_site" {
  bucket = "${aws_s3_bucket.static_app.bucket}"
  key = "index.html"
  source = "index.html"
  depends_on = ["aws_s3_bucket.static_app"]
}


resource "aws_s3_bucket_policy" "we45_s3_bucket_policy" {
  bucket = "${aws_s3_bucket.static_app.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.static_app.id}/*"
    }
  ]
}
EOF
  depends_on = ["aws_s3_bucket.static_app"]
}
