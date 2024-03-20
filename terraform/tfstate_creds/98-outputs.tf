output "access_key" {
    value                   = concat(aws_iam_access_key.tfstate_bucket_user_key.*.id, [null])[0]
}

output "access_secret" {
    value                   = concat(aws_iam_access_key.tfstate_bucket_user_key.*.encrypted_secret, [null])[0]
}
