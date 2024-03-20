terraform {
    required_version        = ">= 0.12"
}

resource "aws_key_pair" "ssh_key" {
    key_name                    = "${var.ssh_public_key_name}"
    public_key                  = var.ssh_public_key
}
