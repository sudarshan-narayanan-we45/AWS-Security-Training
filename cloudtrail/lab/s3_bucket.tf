
variable "bucket_prefix" {
  default = "we45-log-cloudtrails"
}

resource "aws_s3_bucket" "cloud_trail_log_bucket" {
  bucket_prefix = "${var.bucket_prefix}"
  acl           = "private"
  force_destroy = true
}
