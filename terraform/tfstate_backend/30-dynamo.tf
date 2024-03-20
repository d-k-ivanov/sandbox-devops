#---------------------------------------------------------------------------------------------------
# DynamoDB Table for State Locking
#---------------------------------------------------------------------------------------------------
resource "aws_dynamodb_table" "tfstate_backend_locks" {
    name            = "${var.project_name}-${var.environment}-tfstate-lock"
    billing_mode    = "PAY_PER_REQUEST"
    hash_key        = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}
