output "creds" {
    value = <<EOT

--------------------------------------------------------------------------------
Service Name:   "${concat(aws_iam_user.iam_user.*.name, ["null"])[0]}"
Access Key:     "${concat(aws_iam_access_key.iam_user_key.*.id, ["null"])[0]}"
Access Secret:  "${concat(aws_iam_access_key.iam_user_key.*.encrypted_secret, ["null"])[0]}"
--------------------------------------------------------------------------------
EOT
}
