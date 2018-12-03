//Setting up a cloudwatch audit filters where it sends it into alarm notification

//Root User login alarm
resource "aws_cloudwatch_log_metric_filter" "root_login" {
  name           = "root-access"
  pattern        = "{$.userIdentity.type = Root}"
  log_group_name = "${aws_cloudwatch_log_group.cloudtrail_log.name}"

  metric_transformation {
    name      = "RootAccessCount"
    namespace = "${var.metric_name_space}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_login" {
  alarm_name          = "root-access-${var.aws_region}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "RootAccessCount"
  namespace           = "${var.metric_name_space}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Use of the root account has been detected"
  alarm_actions       = ["${aws_sns_topic.security_alerts.arn}"]
}

//Securitygroup changes alarm
resource "aws_cloudwatch_log_metric_filter" "security_group_change" {
  name           = "security-group-changes"
  pattern        = "{ $.eventName = AuthorizeSecurityGroup* || $.eventName = RevokeSecurityGroup* || $.eventName = CreateSecurityGroup || $.eventName = DeleteSecurityGroup }"
  log_group_name = "${aws_cloudwatch_log_group.cloudtrail_log.name}"

  metric_transformation {
    name      = "SecurityGroupChanges"
    namespace = "${var.metric_name_space}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "security_group_change" {
  alarm_name          = "security-group-changes-${var.aws_region}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "SecurityGroupChanges"
  namespace           = "${var.metric_name_space}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "Security groups have been changed"
  alarm_actions       = ["${aws_sns_topic.security_alerts.arn}"]
}

//Iam changes alarm
resource "aws_cloudwatch_log_metric_filter" "iam_change" {
  name           = "iam-changes"
  pattern        = "{$.eventSource = iam.* && $.eventName != Get* && $.eventName != List*}"
  log_group_name = "${aws_cloudwatch_log_group.cloudtrail_log.name}"

  metric_transformation {
    name      = "IamChanges"
    namespace = "${var.metric_name_space}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "iam_change" {
  alarm_name          = "iam-changes-${var.aws_region}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "IamChanges"
  namespace           = "${var.metric_name_space}"
  period              = "60"
  statistic           = "Sum"
  threshold           = "1"
  alarm_description   = "IAM Resources have been changed"
  alarm_actions       = ["${aws_sns_topic.security_alerts.arn}"]
}
