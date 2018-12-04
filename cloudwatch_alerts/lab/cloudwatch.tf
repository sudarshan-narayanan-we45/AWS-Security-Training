//Setting Up Cloudwatch log group

resource "random_string" "random_name" {
  length = 10
  special = false
  upper = false
}

resource "aws_cloudwatch_log_group" "cloudtrail_log" {
  name = "we45-cloudtrail_log-${random_string.random_name.result}"
}
