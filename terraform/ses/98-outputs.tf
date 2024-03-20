output "creds" {
    value = <<EOT

--------------------------------------------------------------------------------
SES Domain:         "${var.dns_zone_name}"
SES Username:       "${concat(aws_iam_user.ses_username.*.name, ["null"])[0]}"
SES Access Key:     "${concat(aws_iam_access_key.ses_user_key.*.id, ["null"])[0]}"
SES SMTP Password:  "${concat(aws_iam_access_key.ses_user_key.*.ses_smtp_password, ["null"])[0]}"
SES STMP Endpoint:  "email-smtp.${var.region}.amazonaws.com"
--------------------------------------------------------------------------------
EOT
}
