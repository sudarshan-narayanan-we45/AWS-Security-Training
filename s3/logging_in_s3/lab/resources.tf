resource "random_string" "log-bucket" {
  length = 10
  special = false
  upper = false
}

resource "random_string" "random-bucket" {
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
  bucket = "${random_string.random-bucket.result}-static"

  logging {
    target_bucket = "${aws_s3_bucket.logs.id}"
    target_prefix = "${var.site_name}/"
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
    routing_rules = <<EOF
    [{
        "Condition": {
            "KeyPrefixEquals": "docs/"
        },
        "Redirect": {
            "ReplaceKeyPrefixWith": "documents/"
        }
    }]
    EOF

  }
  depends_on = ["aws_s3_bucket.logs"]
}

resource "aws_s3_bucket_object" "aws_site" {
  bucket = "${aws_s3_bucket.static_app.bucket}"
  key = "index.html"
  source = "index.html"
  depends_on = ["aws_s3_bucket.static_app"]
}


resource "aws_s3_bucket_policy" "cloud_trail_log_bucket_policy" {
  bucket = "${aws_s3_bucket.static_app.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetTestBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.static_app.arn}/*"
    }

  ]
}
POLICY
  depends_on = ["aws_s3_bucket.static_app"]
}
