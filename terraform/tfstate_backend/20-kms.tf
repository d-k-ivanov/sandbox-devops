#---------------------------------------------------------------------------------------------------
# KMS Key to Encrypt S3 Bucket
#---------------------------------------------------------------------------------------------------
resource "aws_kms_key" "this" {
    description             = "The key used to encrypt the remote state bucket."
    deletion_window_in_days = 30
    enable_key_rotation     = true

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}

resource "aws_kms_alias" "this" {
    name                    = "alias/${var.project_name}-${var.environment}-tfstate"
    target_key_id           = aws_kms_key.this.key_id
}

resource "aws_kms_key" "replica" {
    provider = aws.replica

    description             = "The key used to encrypt the remote state bucket."
    deletion_window_in_days = 30
    enable_key_rotation     = true

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}

resource "aws_kms_alias" "replica" {
    provider = aws.replica

    name                    = "alias/${var.project_name}-${var.environment}-tfstate-replica"
    target_key_id           = aws_kms_key.replica.key_id
}
