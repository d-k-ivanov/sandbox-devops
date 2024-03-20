provider "aws" {
    region          = "${var.region}"
}

resource "aws_key_pair" "ssh_key" {
  key_name          = "${var.project_name}-${var.environment}-ssh-key"
  public_key        = "${var.ssh_key_pair}"
}
