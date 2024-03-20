provider "aws" {
    region                      = var.region
    access_key                  = var.aws_access_key
    secret_key                  = var.aws_secret_key
}

resource "aws_route53_zone" "domain_zone" {
    name                        = var.domain_name
    vpc {
        vpc_id = var.vpc_main
    }
}

resource "aws_route53_zone_association" "vpc_associationa" {
    for_each                    = toset(var.vpc_list)
    zone_id                     = aws_route53_zone.domain_zone.zone_id
    vpc_id                      = each.key
}
