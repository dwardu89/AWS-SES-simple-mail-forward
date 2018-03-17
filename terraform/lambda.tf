
resource "aws_lambda_function" "forward_email_lambda" {
  function_name = "ForwardEmailsUsingSES"
  handler       = "index.handler"
  role          = "${aws_iam_role.lambda_role.arn}"
  runtime       = "nodejs4.3"
  filename      = "files/mail_forward.zip"
  environment {
    variables {
      from_address = "test@dwardu.uk"
      to_address = "hello@dwardu.com"
    }
  }
}


resource "aws_lambda_permission" "new_post_api_gateway_permission" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.forward_email_lambda.function_name}"
  principal     = "sns.amazonaws.com"
  statement_id  = "AllowExecutionFromSNS"
  source_arn    = "${aws_sns_topic.forward_email_topic.arn}"
}
