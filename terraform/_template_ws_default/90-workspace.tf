locals {
    environments = {
        default = {
            aws                                 = "aws"
            project_name                        = "project"
            environment                         = "development"

            region_primary                      = "eu-west-1"
            region_secondary                    = "us-west-1"

            ssh_public_key_name                 = "aws-project-development-ssh-key"
            ssh_public_key                      = "ssh-rsa AAAA aws-project-development-ssh-key.pem"

            dns_zone_id                         = "XXXXXXXXXXXXXXXXXXXXX"
            dns_zone_name                       = "development.project.com"

            eks_cluster_version                 = "1.20"
        }
    }
    workspace = merge(local.environments[terraform.workspace])
}

locals {
    regions = {
        eu-west-1 = {
            name            = "Ireland"
            prefix          = "euw1"
            region          = "eu-west-1"
            vpc             = "vpc-xxxxxxxxxxxxxxxxx"
            subnets_public  = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
            subnets_private = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
        }
        us-west-1 = {
            name            = "N. Virgina"
            prefix          = "usw1"
            region          = "us-west-1"
            vpc             = "vpc-xxxxxxxxxxxxxxxxx"
            subnets_public  = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
            subnets_private = ["subnet-xxxxxxxxxxxxxxxxx", "subnet-xxxxxxxxxxxxxxxxx"]
        }
    }
}
