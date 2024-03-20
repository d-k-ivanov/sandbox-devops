module "qa_user" {
    source                  = "./modules/account_user"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    username                = "qa_user"
    email                   = "qa_user@projectname.com"
    team                    = "QA"
    policy_list             = local.workspace["policy_qa"]
    groups                  = []
    pgp_key                 = var.pgp_key
    is_enabled              = local.workspace["qa_user"]
}

output "qa_user" {
    value                   = module.qa_user.creds
}
