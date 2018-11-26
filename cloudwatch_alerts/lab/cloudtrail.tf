//Cloudtrial Setup

resource "aws_cloudtrail" "ucsf_cloudtrail" {
  name                          = "${var.trail_name}"
  s3_bucket_name                = "${aws_s3_bucket.ucsf_cloud_trail_log_bucket.id}"
  s3_key_prefix                 = "${var.trail_name}"
  include_global_service_events = true
  enable_logging                = true
  is_multi_region_trail         = false
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.ucsf_cloudtrail_log.arn}"
  cloud_watch_logs_role_arn     = "${aws_iam_role.ucsf_cloudtrail_role.arn}"
  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

