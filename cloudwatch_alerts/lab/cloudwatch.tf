//Setting Up Cloudwatch log grouo

resource "aws_cloudwatch_log_group" "ucsf_cloudtrail_log" {
  name = "ucsf_cloudtrail_log"
}
