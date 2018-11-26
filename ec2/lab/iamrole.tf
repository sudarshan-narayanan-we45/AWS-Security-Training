resource "aws_iam_role" "ec2_ssm_access_role" {
  name = "ssm_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ssm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "SSM-policy"
  description = "SSM Policy"
  policy      = "${file("ssm_policy.json")}"
}


resource "aws_iam_policy_attachment" "ec2_ssm_policy_attach" {
  name       = "ec2_ssm_policy_attach"
  roles = ["${aws_iam_role.ec2_ssm_access_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2_ssm_profile"
  role = "${aws_iam_role.ec2_ssm_access_role.name}"
}
