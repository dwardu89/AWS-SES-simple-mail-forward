variable "project_name" {
  default     = "ses-email-forwarding"
  type        = "string"
  description = "The project name"
}

variable "aws_region" {
  default     = "eu-west-1"
  type        = "string"
  description = "The AWS Region to use."
}

variable "domain_name" {
  type        = "string"
  description = "The domain name used for SES."
}

variable "route53_zoneid" {
  type        = "string"
  description = "The zone id for the domain name in Route53."
}

variable "state_bucket_name" {
  type       = "string"
  description = "The bucket location where to store the terraform state file"
}

variable "state_bucket_key" {
  type       = "string"
  description = "The key of the terraform state file."
}

variable "aws_state_bucket_region" {
  default     = "eu-west-2"
  type        = "string"
  description = "The AWS Region of the bucket of the state file."
}

variable "aws_account_id" {
}
