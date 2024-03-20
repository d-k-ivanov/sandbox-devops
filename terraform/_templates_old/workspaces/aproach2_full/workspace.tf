locals {
    environment = {
        prod  = {
            # Main
            environment                 = "prod"
            project_name                 = "XXX"
            # DNS
            dns_zone_id                 = "XXXXXXXX"
            dns_suffix                  = "prod.XXXXXXXX.XXX"
            # ECS
            capacity_min                = 3
            capacity_max                = 10
            capacity_desired            = 3
            ecs_optimized_ami           = "ami-093381d21a4fc38d1"
            instance_size               = "c5.4xlarge"
            # Security
            ssh_key_pair                = "XXXXXXXX"
            ssl_certificate_arn         = "XXXXXXXX"
        }
        stage = {
            # Main
            environment                 = "stage"
            project_name                = "XXX"
            # DNS
            dns_zone_id                 = "XXXXXXXX"
            dns_suffix                  = "stage.XXXXXXXX.XXX"
            # ECS
            capacity_min                = 3
            capacity_max                = 10
            capacity_desired            = 3
            ecs_optimized_ami           = "ami-093381d21a4fc38d1"
            instance_size               = "c5.4xlarge"
            # Security
            ssh_key_pair                = "XXXXXXXX"
            ssl_certificate_arn         = "XXXXXXXX"
        }
    }
    regions = {
        prod = {
            eu-central-1 = {
                vpc_id                  = "vpc-XXXXXXXX"
                public_subnet_a         = "subnet-XXXXXXXX"
                public_subnet_b         = "subnet-XXXXXXXX"
                private_subnet_a        = "subnet-XXXXXXXX"
                private_subnet_b        = "subnet-XXXXXXXX"

                # Extra
                sg_extra_vpn            = "sg-XXXXXXXX"
                sg_extra_rds            = "sg-4XXXXXXXX"
            }

        }
        stage = {
            eu-central-1 = {
                vpc_id                  = "vpc-XXXXXXXX"
                public_subnet_a         = "subnet-XXXXXXXX"
                public_subnet_b         = "subnet-XXXXXXXX"
                private_subnet_a        = "subnet-XXXXXXXX"
                private_subnet_b        = "subnet-XXXXXXXX"

                # Extra
                sg_extra_vpn            = "sg-XXXXXXXX"
                sg_extra_rds            = "sg-XXXXXXXX"
            }

        }
    }

    workspace                           = "${merge(local.environment[terraform.workspace])}"
    region_vars                         = "${merge(local.regions[terraform.workspace])}"
}
