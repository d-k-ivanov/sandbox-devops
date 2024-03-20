resource "aws_security_group" "internal_sg" {
    name                = "${var.project_name}-${var.environment}-internal"
    description         = "${var.project_name}: Internal SG for ${var.environment} environment"
    vpc_id              = var.vpc_id

    tags = {
        Name            = "${var.project_name}-${var.environment}-internal"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_security_group_rule" "internal_sg_rule_allow_self" {
    type                = "ingress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    self                = true
    security_group_id   = aws_security_group.internal_sg.id
}

resource "aws_security_group_rule" "internal_sg_rule_allow_outbound" {
    type                = "egress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.internal_sg.id
}
