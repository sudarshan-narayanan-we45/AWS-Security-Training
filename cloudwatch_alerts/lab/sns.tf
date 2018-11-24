//SNS to send the security alert to cloudwatch alarm

resource "aws_sns_topic" "ucsf_security_alerts" {
  name         = "ucsf-security-alerts-topic"
  display_name = "Security Alerts"
}

resource "aws_sns_topic_subscription" "security_alerts_to_sqs" {
  topic_arn = "${aws_sns_topic.ucsf_security_alerts.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.security_alerts.arn}"
}

resource "aws_sqs_queue" "security_alerts" {
  name = "security-alerts-${var.aws_region}"
}

resource "aws_sqs_queue_policy" "sns_to_sqs" {
  queue_url = "${aws_sqs_queue.security_alerts.id}"

  policy = <<EOF
{
"Version":"2012-10-17",
"Statement":[
  {
    "Effect":"Allow",
    "Principal":"*",
    "Action":"sqs:SendMessage",
    "Resource":"${aws_sqs_queue.security_alerts.arn}",
    "Condition":{
      "ArnEquals":{
        "aws:SourceArn":"${aws_sns_topic.ucsf_security_alerts.arn}"
      }
    }
  }
]
}
EOF
}
