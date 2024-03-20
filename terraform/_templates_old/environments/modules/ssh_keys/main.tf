provider "aws" {
    region          = "${var.region}"
}

resource "aws_key_pair" "XXXXXXXXXXXXXXXX-aws-staging-key" {
  key_name   = "XXXXXXXXXXXXXXXX-aws-staging-key"
  public_key = "XXXXXXXXXXXXXXXX"
}

resource "aws_key_pair" "XXXXXXXXXXXXXXXX-aws-production-key" {
  key_name   = "XXXXXXXXXXXXXXXX-aws-production-key"
  public_key = "XXXXXXXXXXXXXXXX"
}
