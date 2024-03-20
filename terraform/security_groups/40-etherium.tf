resource "aws_security_group" "eth_public_sg" {
    name                = "${var.project_name}-eth-node-public-sg"
    description         = "Public SG for instances in ${var.project_name} environment"
    vpc_id              = var.vpc_id

    tags = {
        Name            = "${var.project_name}-eth-node-public-sg"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_security_group_rule" "eth_public_sg_rule_allow_ssh" {
    type                = "ingress"
    from_port           = 22
    to_port             = 22
    protocol            = "TCP"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.eth_public_sg.id
}

resource "aws_security_group_rule" "eth_public_sg_rule_allow_json_rpc" {
    type                = "ingress"
    from_port           = 8545
    to_port             = 8545
    protocol            = "TCP"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.eth_public_sg.id
}

resource "aws_security_group_rule" "eth_public_sg_rule_allow_anthill" {
    type                = "ingress"
    from_port           = 11223
    to_port             = 11224
    protocol            = "TCP"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.eth_public_sg.id
}

resource "aws_security_group_rule" "eth_public_sg_rule_allow_listener" {
    type                = "ingress"
    from_port           = 30303
    to_port             = 30303
    protocol            = "TCP"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.eth_public_sg.id
}

resource "aws_security_group_rule" "eth_public_sg_rule_allow_discovery" {
    type                = "ingress"
    from_port           = 30303
    to_port             = 30303
    protocol            = "UDP"
    cidr_blocks         = ["0.0.0.0/0"]
    security_group_id   = aws_security_group.eth_public_sg.id
}
