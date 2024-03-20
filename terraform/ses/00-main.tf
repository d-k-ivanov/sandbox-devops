provider "aws" {
    region              = var.region
    access_key          = var.aws_access_key
    secret_key          = var.aws_secret_key
}

resource "aws_ses_domain_identity" "ses_domain" {
    count               = var.service_enabled ? 1 : 0
    domain              = var.dns_zone_name
}

resource "aws_route53_record" "ses_domain_verification_record" {
    count               = var.service_enabled ? 1 : 0
    zone_id             = var.dns_zone_id
    name                = "_amazonses.${var.dns_zone_name}"
    type                = "TXT"
    ttl                 = "600"
    records             = [aws_ses_domain_identity.ses_domain[count.index].verification_token]
}

resource "aws_ses_domain_identity_verification" "ses_domain_verification" {
    count               = var.service_enabled ? 1 : 0
    domain              = aws_ses_domain_identity.ses_domain[count.index].id
    depends_on          = [aws_route53_record.ses_domain_verification_record]
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
    count               = var.service_enabled ? 1 : 0
    domain              = aws_ses_domain_identity.ses_domain[count.index].domain
}

resource "aws_route53_record" "ses_domain_dkim_verification_record" {
    count               = var.service_enabled ? 3 : 0
    zone_id             = var.dns_zone_id
    name                = "${element(aws_ses_domain_dkim.ses_domain_dkim[0].dkim_tokens, count.index)}._domainkey.${var.dns_zone_name}"
    type                = "CNAME"
    ttl                 = "600"
    records             = ["${element(aws_ses_domain_dkim.ses_domain_dkim[0].dkim_tokens, count.index)}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_spf_record_txt" {
    count               = var.service_enabled ? 1 : 0
    zone_id             = var.dns_zone_id
    name                = var.dns_zone_name
    type                = "TXT"
    ttl                 = "600"
    records             = ["v=spf1 include:amazonses.com -all"]
}

resource "aws_route53_record" "ses_domain_mx" {
    count               = var.service_enabled ? 1 : 0
    zone_id             = var.dns_zone_id
    name                = var.dns_zone_name
    type                = "MX"
    ttl                 = "600"
    records             = ["10 feedback-smtp.${var.region}.amazonses.com"]
}

resource "aws_route53_record" "ses_domain_dmarc" {
    count               = var.service_enabled ? 1 : 0
    zone_id             = var.dns_zone_id
    name                = "_dmarc.${var.dns_zone_name}"
    type                = "TXT"
    ttl                 = "600"
    records             = ["v=DMARC1; p=none; rua=mailto:adminv@projectname.com; ruf=mailto:mailto:adminv@projectname.com; fo=1"]
}

resource "aws_iam_user" "ses_username" {
    count               = var.service_enabled ? 1 : 0
    name                = "ses-${replace(var.dns_zone_name, ".", "-")}-${var.region}"
}

resource "aws_iam_user_policy" "ses_policy" {
    count               = var.service_enabled ? 1 : 0
    name                = "${aws_iam_user.ses_username[count.index].name}-policy"
    user                = aws_iam_user.ses_username[count.index].name

    policy              = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ses:SendRawEmail",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_access_key" "ses_user_key" {
    count               = var.service_enabled ? 1 : 0
    user                = aws_iam_user.ses_username[count.index].name
    pgp_key             = var.pgp_key
}
