############################## SSH ################################################
module "ssh_key_eu_west_1" {
    source          = "./modules/ssh_key"
    region          = "eu-west-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

module "ssh_key_us_east_1" {
    source          = "./modules/ssh_key"
    region          = "us-east-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

module "ssh_key_us_west_1" {
    source          = "./modules/ssh_key"
    region          = "us-west-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

module "ssh_key_ap_northeast_1" {
    source          = "./modules/ssh_key"
    region          = "ap-northeast-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

module "ssh_key_ap_east_1" {
    source          = "./modules/ssh_key"
    region          = "ap-east-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

module "ssh_key_sa_east_1" {
    source          = "./modules/ssh_key"
    region          = "sa-east-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    ssh_public_key  = local.workspace["ssh_key"]
}

############################## Security Groups ####################################
module "security_groups_eu_west_1" {
    source          = "./modules/security_groups"
    region          = "eu-west-1"
    aws_access_key  = local.secrets["aws_access_key"]
    aws_secret_key  = local.secrets["aws_secret_key"]
    environment     = local.workspace["environment"]
    project_name    = local.workspace["project_name"]
    vpc_id          = module.vpc_eu_west_1.vpc_id
}
