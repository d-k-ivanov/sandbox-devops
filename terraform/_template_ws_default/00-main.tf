provider "aws" {
    region                  = local.workspace["region_primary"]
    profile                 = "aws-profile-name"
}

provider "aws" {
    alias                   = "secondary"
    region                  = local.workspace["region_secondary"]
    profile                 = "aws-profile-name"
}

terraform {
    required_version        = ">= 0.13"
    backend "s3" {
        key                 = "project-development.tfstate"
        bucket              = "project-development-tfstate"
        dynamodb_table      = "project-development-tfstate-lock"
        region              = "eu-west-1"
        encrypt             = "true"
        profile             = "aws-profile-name"
    }
}

module "tfstate_backend" {
    source                  = "./modules/tfstate_backend"

    providers = {
        aws.replica = aws.secondary
    }

    project_name            = local.workspace["project_name"]
    environment             = local.workspace["environment"]
}
