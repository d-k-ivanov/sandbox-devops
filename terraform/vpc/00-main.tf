#---------------------------------------------------------------------------------------------------
# General settings
#---------------------------------------------------------------------------------------------------
provider "aws" {
    region                      = var.region
    access_key                  = var.aws_access_key
    secret_key                  = var.aws_secret_key
}

resource "aws_vpc" "vpc" {
    cidr_block                  = local.region_vars["vpc_net"]
    enable_dns_hostnames        = true
    enable_dns_support          = true

    tags = {
        Name                    = "${var.project_name}-${var.environment}-vpc"
        Terraform               = "True"
    }
}

resource "aws_subnet" "public_subnet_a" {
    vpc_id                      = aws_vpc.vpc.id
    availability_zone           = local.region_vars["az_one"]
    cidr_block                  = local.region_vars["public_subnet_a"]
    map_public_ip_on_launch     = true
    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-subnet-a"
        Terraform               = "True"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id                      = aws_vpc.vpc.id
    availability_zone           = local.region_vars["az_two"]
    cidr_block                  = local.region_vars["public_subnet_b"]
    map_public_ip_on_launch     = true
    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-subnet-b"
        Terraform               = "True"
    }
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id                      = aws_vpc.vpc.id
    availability_zone           = local.region_vars["az_one"]
    cidr_block                  = local.region_vars["private_subnet_a"]
    tags = {
        Name                    = "${var.project_name}-${var.environment}-private-subnet-a"
        Terraform               = "True"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id                      = aws_vpc.vpc.id
    availability_zone           = local.region_vars["az_two"]
    cidr_block                  = local.region_vars["private_subnet_b"]
    tags = {
        Name                    = "${var.project_name}-${var.environment}-private-subnet-b"
        Terraform               = "True"
    }
}
