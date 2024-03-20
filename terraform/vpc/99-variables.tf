
variable "region"                       {}
variable "aws_access_key"               {}
variable "aws_secret_key"               {}
variable "environment"                  {}
variable "project_name"                 {}

locals {
    regions = {
        // Hong Kong
        ap-east-1 = {
            vpc_net                     = "10.1.0.0/16"
            public_subnet_a             = "10.1.0.0/20"
            public_subnet_b             = "10.1.16.0/20"
            private_subnet_a            = "10.1.32.0/20"
            private_subnet_b            = "10.1.48.0/20"
            az_one                      = "ap-east-1a"
            az_two                      = "ap-east-1b"
        }
        // Tokyo
        ap-northeast-1 = {
            vpc_net                     = "10.2.0.0/16"
            public_subnet_a             = "10.2.0.0/20"
            public_subnet_b             = "10.2.16.0/20"
            private_subnet_a            = "10.2.32.0/20"
            private_subnet_b            = "10.2.48.0/20"
            az_one                      = "ap-northeast-1a"
            az_two                      = "ap-northeast-1c"
        }
        // Ireland
        eu-west-1 = {
            vpc_net                     = "10.3.0.0/16"
            public_subnet_a             = "10.3.0.0/20"
            public_subnet_b             = "10.3.16.0/20"
            private_subnet_a            = "10.3.32.0/20"
            private_subnet_b            = "10.3.48.0/20"
            az_one                      = "eu-west-1a"
            az_two                      = "eu-west-1b"
        }
        // Sao Paolo
        sa-east-1 = {
            vpc_net                     = "10.4.0.0/16"
            public_subnet_a             = "10.4.0.0/20"
            public_subnet_b             = "10.4.16.0/20"
            private_subnet_a            = "10.4.32.0/20"
            private_subnet_b            = "10.4.48.0/20"
            az_one                      = "sa-east-1a"
            az_two                      = "sa-east-1b"
        }
        // N. Virginia
        us-east-1 = {
            vpc_net                     = "10.5.0.0/16"
            public_subnet_a             = "10.5.0.0/20"
            public_subnet_b             = "10.5.16.0/20"
            private_subnet_a            = "10.5.32.0/20"
            private_subnet_b            = "10.5.48.0/20"
            az_one                      = "us-east-1a"
            az_two                      = "us-east-1b"
        }
        // Northern California
        us-west-1 = {
            vpc_net                     = "10.6.0.0/16"
            public_subnet_a             = "10.6.0.0/20"
            public_subnet_b             = "10.6.16.0/20"
            private_subnet_a            = "10.6.32.0/20"
            private_subnet_b            = "10.6.48.0/20"
            az_one                      = "us-west-1a"
            az_two                      = "us-west-1b"
        }
    }
    region_vars                         = merge(local.regions[var.region])
}
