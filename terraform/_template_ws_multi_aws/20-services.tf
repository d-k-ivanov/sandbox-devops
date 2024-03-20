# AWS Deployment Service Account
module "aws_service_deployer" {
    source                  = "./modules/account_service"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "aws_service_deployer"
    email                   = "aws_service_deployer@projectname.com"
    team                    = "DevOps"
    policy_list             = concat(local.workspace["policy_admin"])
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["aws_service_deployer"]
}

output "aws_service_deployer" {
    value                   = module.aws_service_deployer.creds
}

# AWS Downoader Service Account
module "aws_service_downloader" {
    source                  = "./modules/account_service"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "aws_service_downloader"
    email                   = "aws_service_downloader@projetname.com"
    team                    = "DevOps"
    policy_list             = concat(local.workspace["policy_read_only"])
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["aws_service_downloader"]
}

output "aws_service_downloader" {
    value                   = module.aws_service_downloader.creds
}
