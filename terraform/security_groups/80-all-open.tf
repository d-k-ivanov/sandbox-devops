resource "aws_security_group" "all_open_sg" {
    name                = "${var.project_name}-${var.environment}-all-open-sg"
    description         = "Public SG for TEST instances in ${var.project_name} ${var.environment} environment"
    vpc_id              = var.vpc_id

    tags = {
        Name            = "${var.project_name}-${var.environment}-all-open-sg"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_security_group_rule" "all_open_sg_rule_allow_all_out" {
    type                = "egress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.all_open_sg.id
}

resource "aws_security_group_rule" "all_open_sg_rule_allow_all_in" {
    type                = "ingress"
    from_port           = 0
    to_port             = 0
    protocol            = "-1"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.all_open_sg.id
}
