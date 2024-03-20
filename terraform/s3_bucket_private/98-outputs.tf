output "access_key" {
    value                           = aws_iam_access_key.data_bucket_user_key.*.id
}

output "access_secret" {
    value                           = aws_iam_access_key.data_bucket_user_key.*.encrypted_secret
}

output "access_password" {
    value                           = aws_iam_user_login_profile.data_bucket_user_profile.*.encrypted_password
}
