provider "aws" {
    region                      = "${var.region}"
}

data "template_file" "ecr_policy" {
    template                    = "${file("${path.module}/ecr_policy.tpl")}"

    vars {
        project_name            = "${var.project_name}"
        environment             = "${var.environment}"
        ecs_instance_role_arn   = "${var.ecs_instance_role_arn}"
        ecs_task_role_arn       = "${var.ecs_task_role_arn}"
    }
}
