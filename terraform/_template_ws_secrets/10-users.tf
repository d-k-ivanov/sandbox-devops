# Dmitry Ivanov
module "dmitry_ivanov" {
    source                  = "./modules/accout_user"
    region                  = local.workspace["region_users"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "divanov"
    email                   = "divanov@projectname.com"
    team                    = "DevOps"
    policy_list             = concat(local.workspace["policy_admin"], [module.tfstate_backend.iam_policy.arn])
    groups                  = []
    pgp_key                 = var.pgp_key
}

output "dmitry_ivanov" {
    value                   = module.dmitry_ivanov.credentials
}
