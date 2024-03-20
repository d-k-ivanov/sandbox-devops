resource "aws_security_group" "bastion_sg" {
    name                        = "${var.project_name}-${var.environment}-bastion-public"
    description                 = "${var.project_name}: Bastion SG for ${var.environment} environment"
    vpc_id                      = var.vpc_id

    tags = {
        Name                    = "${var.project_name}-${var.environment}-bastion-public"
        Environment             = var.environment
        Project                 = var.project_name
        Terraform               = "True"
    }
}
resource "aws_security_group_rule" "bastion_egress_internet" {
    description                 = "Allow bastion egress to the Internet."
    protocol                    = "-1"
    security_group_id           = aws_security_group.bastion_sg.id
    cidr_blocks                 = ["0.0.0.0/0"]
    from_port                   = 0
    to_port                     = 0
    type                        = "egress"
}

resource "aws_security_group_rule" "bastion_sg_rule_allow_SSH" {
    type                        = "ingress"
    from_port                   = 22
    to_port                     = 22
    protocol                    = "TCP"
    cidr_blocks                 = var.allowed_external_cidrs
    security_group_id           = aws_security_group.bastion_sg.id
}
