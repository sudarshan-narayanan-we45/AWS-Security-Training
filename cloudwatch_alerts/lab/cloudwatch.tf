//Setting Up Cloudwatch log grouo

resource "aws_cloudwatch_log_group" "cloudtrail_log" {
  name = "cloudtrail_log"
}
