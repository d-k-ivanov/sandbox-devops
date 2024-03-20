resource "aws_s3_bucket" "data_bucket" {
    count                           = var.service_enabled ? 1 : 0
    bucket                          = "${var.project_name}-${var.environment}-${var.subsystem}-bucket"
    acl                             = "private"

    tags = {
        Name                        = "${var.project_name}-${var.environment}-${var.subsystem}-bucket"
        Project                     = var.project_name
        Environment                 = var.environment
        Terraform                   = "True"
    }

}
