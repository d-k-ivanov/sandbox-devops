data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_ami" "amazonlinux" {
    most_recent     = true
    owners          = ["amazon"]
    name_regex      = "^amzn2-ami-hvm.*-ebs"

    filter {
        name        = "architecture"
        values      = ["x86_64"]
    }
}

data "template_file" "user_data" {
    template        = "${file("${path.module}/files/userdata.tpl")}"
}
