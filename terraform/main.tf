provider "aws" {
  region = "${var.aws_region}"
}


terraform {
  backend "s3" {
    bucket = "dwardu-terraform-states"
    key    = "sandbox/sesmail"
    region = "eu-west-2"
  }
}
