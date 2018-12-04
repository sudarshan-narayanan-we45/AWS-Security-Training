
resource "aws_cloudtrail" "we45_cloudtrial" {
  name                          = "we45-trail-cloudtrails"
  s3_bucket_name                = "${aws_s3_bucket.cloud_trail_log_bucket.id}"
  include_global_service_events = false
  event_selector {
    read_write_type = "All"
    include_management_events = true

    data_resource {
      type = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }
}
