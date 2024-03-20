#---------------------------------------------------------------------------------------------------
# General settings
#---------------------------------------------------------------------------------------------------

terraform {
    required_version        = ">= 0.13"

    required_providers {
        aws = {
            source          = "hashicorp/aws"
            version         = "~> 3.0"
        }
    }
}

provider "aws" {
    alias                   = "this"
    region                  = var.aws_region_this
    access_key              = var.aws_access_key
    secret_key              = var.aws_secret_key
}

provider "aws" {
    alias                   = "peer"
    region                  = var.aws_region_peer
    access_key              = var.aws_access_key
    secret_key              = var.aws_secret_key
}
