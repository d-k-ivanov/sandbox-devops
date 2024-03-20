provider "aws" {
    region                  = local.workspace["region_users"]
}

terraform {
    required_version        = ">= 0.13"
    backend "s3" {
        key                 = "development.tfstate"
        bucket              = "projectname-development-tfstate"
        dynamodb_table      = "projectname-development-tfstate-lock"
        region              = "eu-west-1"
        encrypt             = "true"
    }
}

module "tfstate_backend" {
    source                  = "./modules/tfstate_backend"
    aws_region_main         = "eu-west-1"
    aws_region_replica      = "us-east-1"
    aws_access_key          = local.secrets["aws_access_key"]
    aws_secret_key          = local.secrets["aws_secret_key"]
    project_name            = local.workspace["project_name"]
    environment             = local.workspace["environment"]
    pgp_key                 = var.pgp_key
}

output "tfstate_backend_credentials" {
    value                   = module.tfstate_backend.credentials
}
