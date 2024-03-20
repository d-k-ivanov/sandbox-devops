provider "aws" {
    region                          = local.workspace["region"]
}

terraform {
    required_version        = ">= 0.13"
    backend "s3" {
        bucket              = "project-name-tfstate"
        key                 = "project-name.tfstate"
        dynamodb_table      = "project-name-tfstate-lock"
        region              = "us-west-1"
        encrypt             = "true"
        access_key          = "XXXXXXXXXXXXXXXXXXXX"
        secret_key          = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
        # profile             = "aws-profile-name"
    }
}

module "tfstate_backend" {
    source                  = "./modules/tfstate_backend"

    project_name            = local.workspace["project_name"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    region_main             = "us-west-1"
    region_replica          = "eu-west-1"
    is_s3_tfstate_handler   = local.workspace["is_s3_tfstate_handler"]
}


module "tfstate_creds" {
    source                  = "./modules/tfstate_creds"
    region                  = local.workspace["region"]
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    suffix                  = "main"
    pgp_key                 = var.pgp_key
    is_s3_tfstate_handler   = local.workspace["is_s3_tfstate_handler"]
}

output "tfstate_access_key" {
    value                   = module.tfstate_creds.access_key
}

output "tfstate_access_secret" {
    value                   = module.tfstate_creds.access_secret
}
