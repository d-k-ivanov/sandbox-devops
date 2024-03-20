output "credentials" {
    value = <<EOT

--------------------------------------------------------------------------------
Username:       "${aws_iam_user.iam_user.name}"
Password:       "${aws_iam_user_login_profile.iam_user_profile.encrypted_password}"
Access Key:     "${aws_iam_access_key.iam_user_key.id}"
Access Secret:  "${aws_iam_access_key.iam_user_key.encrypted_secret}"
--------------------------------------------------------------------------------
EOT
}
