output "kms_key" {
    description                 = "The KMS customer master key to encrypt state buckets."
    value                       = aws_kms_key.this
}

output "state_bucket" {
    description                 = "The S3 bucket to store the remote state file."
    value                       = aws_s3_bucket.state
}

output "replica_bucket" {
    description                 = "The S3 bucket to replicate the state S3 bucket."
    value                       = aws_s3_bucket.replica
}

output "dynamodb_table" {
    description                 = "The DynamoDB table to manage lock states."
    value                       = aws_dynamodb_table.tfstate_backend_locks
}

output "iam_policy" {
    description                 = "The IAM Policy to access remote state environment."
    value                       = aws_iam_policy.tfstate_backend_policy
}
