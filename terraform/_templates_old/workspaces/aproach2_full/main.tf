terraform {
    backend "s3" {
        bucket              = "XXXXXXXXXXXXXXXX-tf-states"
        key                 = "XXXXXXXXXXXXXXXX.tfstate"
        region              = "eu-central-1"
        encrypt             = "true"
    }
}

module "deploy_to_us_west_2" {
    source                  = "modules/deploy_to_region"

    # Main
    region                  = "eu-central-1"
    environment             = "${local.workspace["environment"]}"
    project_name                 = "${local.workspace["project_name"]}"

    # DNS
    dns_zone_id             = "${local.workspace["dns_zone_id"]}"
    dns_suffix              = "${local.workspace["dns_suffix"]}"

    # ECS
    capacity_min            = "${local.workspace["capacity_min"]}"
    capacity_max            = "${local.workspace["capacity_max"]}"
    capacity_desired        = "${local.workspace["capacity_desired"]}"
    ecs_optimized_ami       = "${local.workspace["ecs_optimized_ami"]}"
    instance_size           = "${local.workspace["instance_size"]}"

    # Network
    vpc_id                  = "${lookup(local.region_vars["eu-central-1"], "vpc_id")}"
    public_subnet_a         = "${lookup(local.region_vars["eu-central-1"], "public_subnet_a")}"
    public_subnet_b         = "${lookup(local.region_vars["eu-central-1"], "public_subnet_b")}"
    private_subnet_a        = "${lookup(local.region_vars["eu-central-1"], "private_subnet_a")}"
    private_subnet_b        = "${lookup(local.region_vars["eu-central-1"], "private_subnet_b")}"

    # Secutriy
    ssh_key_pair            = "${local.workspace["ssh_key_pair"]}"
    ssl_certificate_arn     = "${local.workspace["ssl_certificate_arn"]}"

    # Extra
    sg_extra_vpn            = "${lookup(local.region_vars["eu-central-1"], "sg_extra_vpn")}"
    sg_extra_rds            = "${lookup(local.region_vars["eu-central-1"], "sg_extra_rds")}"
}
