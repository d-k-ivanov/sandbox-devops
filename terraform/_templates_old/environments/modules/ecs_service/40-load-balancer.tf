# data "aws_lb" "ecs_service_lb" {
#   arn  = "${var.ecs_load_balancer_arn}"
# }

resource "aws_lb_target_group" "ecs_service_tg" {
    name                    = "${var.project_name}-${var.environment}-${var.sub_environment}-${var.service_name}"
    port                    = "${var.service_port}"
    protocol                = "HTTP"
    vpc_id                  = "${var.vpc_id}"
    target_type             = "ip"

    health_check {
        path                = "${var.health_check_path}"
        interval            = 120
        timeout             = 60
        healthy_threshold   = 2
        unhealthy_threshold = 10
        matcher             = "200,302"
    }

    tags {
        Name                = "${var.project_name}-${var.environment}-${var.sub_environment}-${var.service_name}"
        Environment         = "${var.environment}"
        Project             = "${var.project_name}"
        Terraform           = "True"
    }
}

resource "aws_lb_listener_rule" "ecs_service_lb_rule" {
    listener_arn            = "${var.ecs_listener_arn}"
    priority                = "${var.listener_rule_priority}"

    action {
        type                = "forward"
        target_group_arn    = "${aws_lb_target_group.ecs_service_tg.arn}"
    }

    condition {
        field               = "host-header"
        values              = ["${var.service_name}.${var.environment}.${var.dns_suffix}"]
    }
}
