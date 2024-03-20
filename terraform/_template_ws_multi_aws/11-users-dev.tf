module "dev_user" {
    source                  = "./modules/account_user"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "dev_user"
    email                   = "dev_user@projectname.com"
    team                    = "DEV"
    policy_list             = local.workspace["policy_dev"]
    groups                  = []
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["dev_user"]
}

output "dev_user" {
    value                   = module.dev_user.creds
}
