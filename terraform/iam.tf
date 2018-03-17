resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${var.project_name}-lambda-policy-for-lambda"
  policy = "${data.template_file.lambda_policy.rendered}"
}

data "template_file" "lambda_policy" {
  template = "${file("files/lambdapolicy.json")}"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
  role       = "${aws_iam_role.lambda_role.id}"
}


resource "aws_iam_policy" "mail_forward_policy" {
  name   = "${var.project_name}-mail-forwarding-policy-for-lambda"
  policy = "${data.template_file.mail_forward_policy.rendered}"
}

data "template_file" "mail_forward_policy" {
  template = "${file("files/mail_forward_policy.json")}"
}

resource "aws_iam_role_policy_attachment" "mail_forward_policy_attachment" {
  policy_arn = "${aws_iam_policy.mail_forward_policy.arn}"
  role       = "${aws_iam_role.lambda_role.id}"
}
