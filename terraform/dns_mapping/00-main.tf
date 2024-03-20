
provider "aws" {
    region                          = var.region
    access_key                      = var.aws_access_key
    secret_key                      = var.aws_secret_key
}

resource "aws_route53_record" "dns_mapping" {
  zone_id                           = var.dns_zone_id
  name                              = var.dns_name
  type                              = "A"
  ttl                               = "300"
  records                           = var.ip
}
