resource "aws_sns_topic" "forward_email_topic" {
  name         = "${var.project_name}-email-forwarding"
  display_name = "Email Forwarding for ${var.project_name}"
}

resource "aws_sns_topic_subscription" "forward_email_topic_lambda_subscription" {
  topic_arn = "${aws_sns_topic.forward_email_topic.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.forward_email_lambda.arn}"
}