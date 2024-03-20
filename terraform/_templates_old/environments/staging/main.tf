terraform {
    backend "s3" {
        bucket                          = "XXXXXXXXXXXXXXXX-tf-states"
        key                             = "XXXXXXXXXXXXXXXX-staging.tfstate"
        region                          = "eu-central-1"
        encrypt                         = "true"
    }
}

module "security_groups_usw2" {
    source                              = "../modules/security_groups"
    region                              = "eu-central-1"
    environment                         = "staging"
    project_name                        = "XXXXXXXXXXXXXXXX"
    vpc_id                              = "vpc-XXXXXXXX"
}

module "bastion_usw2" {
    source                              = "../modules/bastion"
    region                              = "eu-central-1"
    environment                         = "staging"
    project_name                        = "XXXXXXXXXXXXXXXX"
    key_name                            = "${var.key_name}"
    security_groups                     = [
        "${module.security_groups_usw2.bastion_public_sg}",
        "${module.security_groups_usw2.ecs_instance_sg}",
    ]
    subnet                              = "subnet-XXXXXXXX"
}

module "staging-ecs-cluster" {
    source                              = "../modules/ecs_cluster"
    region                              = "eu-central-1"
    environment                         = "staging"
    project_name                        = "XXXXXXXXXXXXXXXX"
    dns_zone_id                         = "XXXXXXXXXXXXXXXX"
    dns_suffix                          = "XXX.XXXXXXXXXXXXX.XXX"
    ecs_optimized_ami                   = "ami-00d4f478"
    instance_size                       = "m5.xlarge"
    min_size                            = "3"
    max_size                            = "10"
    desired_capacity                    = "3"
    key_name                            = "${var.key_name}"
    instance_security_groups            = ["${module.security_groups_usw2.ecs_instance_sg}", "sg-XXXXXXXX", "sg-XXXXXXXX"]
    alb_security_groups                 = ["${module.security_groups_usw2.alb_public_sg}"]
    vpc_id                              = "vpc-XXXXXXXX"
    private_subnets                     = ["subnet-XXXXXXXX"]
    public_subnets                      = ["subnet-XXXXXXXX"]
}


module "staging-ecr" {
    source                              = "../modules/ecr"
    region                              = "eu-central-1"
    environment                         = "staging"
    project_name                        = "XXXXXXXXXXXXXXXX"
    ecs_instance_role_arn               = "${module.staging-ecs-cluster.ecs_instance_role_arn}"
    ecs_task_role_arn                   = "${module.staging-ecs-cluster.ecs_task_role_arn}"
}
