resource "aws_kms_key" "s3_key" {
  description = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "random_string" "bucket_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_s3_bucket" "secret_bucket" {
 bucket = "${random_string.bucket_name.result}-we45-training"

 server_side_encryption_configuration {
   "rule" {
     "apply_server_side_encryption_by_default" {
       kms_master_key_id = "${aws_kms_key.s3_key.arn}"
       sse_algorithm = "aws:kms"
     }
   }
 }
}