module "admin_user" {
    source                  = "./modules/account_user"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "admin_user"
    email                   = "admin_user@projectname.com"
    team                    = "DevOps"
    policy_list             = concat(local.workspace["policy_admin"])
    groups                  = []
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["admin_user"]
}

output "admin_user" {
    value                   = module.admin_user.creds
}
