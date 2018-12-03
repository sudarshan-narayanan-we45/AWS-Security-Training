resource "aws_flow_log" "aws_vpc_flow_log" {
  iam_role_arn = "${aws_iam_role.vpc_flow_iam_role.arn}"
  log_destination = "${aws_cloudwatch_log_group.vpc_flow_cloud_watch_group.arn}"
  traffic_type = "ALL",
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_cloudwatch_log_group" "vpc_flow_cloud_watch_group" {
  name = "aws-vpc-flow-log"
}

resource "aws_iam_role" "vpc_flow_iam_role" {
  name = "flowlogsRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_flow_log_iam_policy" {
  name = "flowlogsRolePolicy"
  role = "${aws_iam_role.vpc_flow_iam_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
