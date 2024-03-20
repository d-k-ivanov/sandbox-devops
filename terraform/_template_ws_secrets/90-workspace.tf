locals {
    environments = {
        default = {
            aws                                 = "aws"
            project_name                        = "projectname"
            environment                         = "development"

            domain_name                         = "projectname.com"

            region_main                         = "eu-west-1"
            region_users                        = "eu-west-1"

            region_ape1                         = "ap-east-1"       // Hong Kong
            region_apn1                         = "ap-northeast-1"  // Tokyo
            region_euw1                         = "eu-west-1"       // Ireland
            region_sae1                         = "sa-east-1"       // Sao Paolo
            region_use1                         = "us-east-1"       // N. Virginia
            region_usw1                         = "us-west-1"       // Northern California
            is_s3_tfstate_handler               = false

            # Services:
            # service_aws_deployer                = true

            # Users:
            # user_aws_deployer                   = true

            ssh_key                             = "ssh-rsa AAAA"

            // Policies
            policy_admin        = [
                "arn:aws:iam::aws:policy/AdministratorAccess"
            ]
            policy_read_only    = [
                "arn:aws:iam::aws:policy/ReadOnlyAccess"
            ]
        }
    }
    workspace = merge(local.environments[terraform.workspace])
}

locals {
    regions = {
        ap-east-1 = {
            name        = "Hong Kong"
            prefix      = "ape1"
            region      = "ap-east-1"
        }
        ap-northeast-1 = {
            name        = "Tokyo"
            prefix      = "apn1"
            region      = "ap-northeast-1"
        }
        eu-west-1 = {
            name        = "Ireland"
            prefix      = "euw1"
            region      = "eu-west-1"
        }
        sa-east-1 = {
            name        = "Sao Paolo"
            prefix      = "sae1"
            region      = "sa-east-1"
        }
        ap-east-1 = {
            name        = "N. Virginia"
            prefix      = "use1"
            region      = "ap-east-1"
        }
        us-east-1 = {
            name        = "Northern California"
            prefix      = "usw1"
            region      = "us-east-1"
        }
    }
}
