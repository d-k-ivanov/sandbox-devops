resource "aws_route53_record" "bastion_record_name" {
    name    = "bastion.${var.dns_zone_name}"
    zone_id = var.dns_zone_id
    type    = "A"

    alias {
        evaluate_target_health  = true
        name                    = aws_lb.bastion_lb.dns_name
        zone_id                 = aws_lb.bastion_lb.zone_id
    }
}
