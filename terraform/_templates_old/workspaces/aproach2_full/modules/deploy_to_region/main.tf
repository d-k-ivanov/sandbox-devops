module "ssh_keys" {
    source                      = "../distribute_ssh_keys"
    region                      = "${var.region}"
    environment                 = "${var.environment}"
    project_name                = "${var.project_name}"
    ssh_key_pair                = "${var.ssh_key_pair}"
}

module "security_groups" {
    source                      = "../security_groups"
    region                      = "${var.region}"
    environment                 = "${var.environment}"
    project_name                = "${var.project_name}"
    vpc_id                      = "${var.vpc_id}"
}


module "bastion" {
    source                      = "../bastion"
    region                      = "${var.region}"
    environment                 = "${var.environment}"
    project_name                = "${var.project_name}"
    key_name                    = "${module.ssh_keys.key_name}"
    security_groups             = [
        "${module.security_groups.bastion_public_sg}",
        "${module.security_groups.ecs_instance_sg}",
    ]
    subnet                      = "${var.public_subnet_a}"
}

module "ecs_cluster" {
    source                      = "../ecs_cluster"
    region                      = "${var.region}"
    environment                 = "${var.environment}"
    project_name                = "${var.project_name}"
    dns_zone_id                 = "${var.dns_zone_id}"
    dns_suffix                  = "${var.dns_suffix}"
    ssl_certificate_arn         = "${var.ssl_certificate_arn}"
    ecs_optimized_ami           = "${var.ecs_optimized_ami}"
    instance_size               = "${var.instance_size}"
    capacity_min                = "${var.capacity_min}"
    capacity_max                = "${var.capacity_max}"
    capacity_desired            = "${var.capacity_desired}"
    key_name                    = "${module.ssh_keys.key_name}"
    instance_security_groups    = ["${module.security_groups.ecs_instance_sg}", "${var.sg_extra_vpn}", "${var.sg_extra_rds}"]
    alb_security_groups         = ["${module.security_groups.alb_public_sg}"]
    vpc_id                      = "${var.vpc_id}"
    public_subnets              = ["${var.public_subnet_a}", "${var.public_subnet_b}"]
    private_subnets             = ["${var.private_subnet_a}", "${var.private_subnet_b}"]
}

module "ecr" {
    source                      = "../ecr"
    region                      = "${var.region}"
    environment                 = "${var.environment}"
    project_name                = "${var.project_name}"
    ecs_instance_role_arn       = "${module.ecs_cluster.ecs_instance_role_arn}"
    ecs_task_role_arn           = "${module.ecs_cluster.ecs_task_role_arn}"
}
