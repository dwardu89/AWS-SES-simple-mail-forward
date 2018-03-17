resource "aws_ses_receipt_rule_set" "ses_rule_set" {
  rule_set_name = "${var.project_name}-rule-set"

}

resource "aws_ses_domain_identity" "domain_identity" {
  domain = "${var.domain_name}"
}

resource "aws_ses_domain_dkim" "site_domain_dkim" {
  domain = "${aws_ses_domain_identity.domain_identity.domain}"
}

# Add a header to the email and push it to an sns topic.
resource "aws_ses_receipt_rule" "store" {
  name          = "store"
  rule_set_name = "${aws_ses_receipt_rule_set.ses_rule_set.id}"
  recipients    = [
    "administrator@${var.domain_name}",
    "hostmaster@${var.domain_name}",
    "postmaster@${var.domain_name}",
    "webmaster@${var.domain_name}",
    "admin@${var.domain_name}"
  ]
  enabled       = true
  scan_enabled  = true

  add_header_action {
    header_name  = "Custom-Header"
    header_value = "Added by SES"
    position = 0
  }

  sns_action {
    position = 1
    topic_arn = "${aws_sns_topic.forward_email_topic.arn}"
  }
}


resource "aws_route53_record" "domain_amazonses_verification_token_record" {
  count   = 1
  zone_id = "${var.route53_zoneid}"
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = "600"

  records = ["${aws_ses_domain_identity.domain_identity.verification_token}"]
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  count   = 3
  zone_id = "${var.route53_zoneid}"
  name    = "${element(aws_ses_domain_dkim.site_domain_dkim.dkim_tokens, count.index)}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.site_domain_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}