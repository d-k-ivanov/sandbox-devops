resource "aws_lb" "bastion_lb" {
    name                = "${var.project_name}-${var.environment}-bastion"
    internal            = false
    subnets             = var.subnets_public
    load_balancer_type  = "network"

    tags = {
        Name            = "${var.project_name}-${var.environment}-bastion"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_lb_target_group" "bastion_lb_target_group" {
    name                = "${var.project_name}-${var.environment}-bastion-ssh"
    port                = 22
    protocol            = "TCP"
    vpc_id              = var.vpc_id
    target_type         = "instance"

    health_check {
        port            = "traffic-port"
        protocol        = "TCP"
    }

    tags = {
        Name            = "${var.project_name}-${var.environment}-bastion"
        Environment     = var.environment
        Project         = var.project_name
        Terraform       = "True"
    }
}

resource "aws_lb_listener" "bastion_lb_listener_22" {
    default_action {
        target_group_arn = aws_lb_target_group.bastion_lb_target_group.arn
        type             = "forward"
    }

    load_balancer_arn   = aws_lb.bastion_lb.arn
    port                = 22
    protocol            = "TCP"
}
