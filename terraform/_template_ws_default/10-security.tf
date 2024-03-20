module "ssh_key" {
    source                  = "./modules/ssh_key"
    ssh_public_key_name     = local.workspace["ssh_public_key_name"]
    ssh_public_key          = local.workspace["ssh_public_key"]
}

module "security_groups" {
    source          = "./modules/security_groups"
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    vpc_id          = local.regions[local.workspace["region_primary"]]["vpc"]
}

module "iams" {
    source          = "./modules/iams"
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
}

module "bastion" {
    source          = "./modules/bastion"
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]

    vpc_id          = local.regions[local.workspace["region_primary"]]["vpc"]
    subnets_public  = local.regions[local.workspace["region_primary"]]["subnets_public"]

    dns_zone_id     = local.workspace["dns_zone_id"]
    dns_zone_name   = local.workspace["dns_zone_name"]

    ssh_key_name    = module.ssh_key.ssh_key_name

    security_groups = [
        module.security_groups.bastion_sg,
        module.security_groups.internal_sg
    ]
}
