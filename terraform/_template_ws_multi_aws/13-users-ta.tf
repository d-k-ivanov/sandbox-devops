# Aleksey Alekseenko
module "ta_user" {
    source                  = "./modules/account_user"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "ta_user"
    email                   = "ta_user@projectname.com"
    team                    = "TA"
    policy_list             = local.workspace["policy_ta"]
    groups                  = []
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["ta_user"]
}

output "ta_user" {
    value                   = module.ta_user.creds
}
