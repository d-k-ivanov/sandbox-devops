locals {
    define_lifecycle_rule  = var.noncurrent_version_expiration != null || length(var.noncurrent_version_transitions) > 0
}

#---------------------------------------------------------------------------------------------------
# Buckets
#---------------------------------------------------------------------------------------------------
data "aws_region" "state" {
}

data "aws_region" "replica" {
    provider = aws.replica
}

resource "aws_s3_bucket" "state" {
    bucket                          = "${var.project_name}-${var.environment}-tfstate"
    acl                             = "private"
    force_destroy                   = false

    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "aws:kms"
                kms_master_key_id = aws_kms_key.this.arn
            }
        }
    }

    replication_configuration {
        role = aws_iam_role.tfstate_backend_replica_role.arn

        rules {
            id = "replica_configuration"
            prefix = ""
            status = "Enabled"

            source_selection_criteria {
                sse_kms_encrypted_objects {
                    enabled = true
                }
            }

            destination {
                bucket = aws_s3_bucket.replica.arn
                storage_class = "STANDARD"
                replica_kms_key_id = aws_kms_key.replica.arn
            }
        }
    }

    dynamic "lifecycle_rule" {
        for_each = local.define_lifecycle_rule ? [true] : []

        content {
            enabled = true
            dynamic "noncurrent_version_transition" {
                for_each = var.noncurrent_version_transitions

                content {
                    days = noncurrent_version_transition.value.days
                    storage_class = noncurrent_version_transition.value.storage_class
                }
            }

            dynamic "noncurrent_version_expiration" {
                for_each = var.noncurrent_version_expiration != null ? [var.noncurrent_version_expiration] : []

                content {
                    days = noncurrent_version_expiration.value.days
                }
            }
        }
    }

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}

resource "aws_s3_bucket" "replica" {
    provider                        = aws.replica
    bucket                          = "${var.project_name}-${var.environment}-tfstate-replica"
    force_destroy                   = false

    versioning {
        enabled = true
    }

    dynamic "lifecycle_rule" {
        for_each = local.define_lifecycle_rule ? [true] : []

        content {
            enabled = true

            dynamic "noncurrent_version_transition" {
                for_each = var.noncurrent_version_transitions

                content {
                    days = noncurrent_version_transition.value.days
                    storage_class = noncurrent_version_transition.value.storage_class
                }
            }
            dynamic "noncurrent_version_expiration" {
                for_each = var.noncurrent_version_expiration != null ? [var.noncurrent_version_expiration] : []

                content {
                    days = noncurrent_version_expiration.value.days
                }
            }
        }
    }

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}

resource "aws_s3_bucket_public_access_block" "state" {
    bucket                          = aws_s3_bucket.state.id
    block_public_acls               = true
    block_public_policy             = true
    ignore_public_acls              = true
    restrict_public_buckets         = true
}

resource "aws_s3_bucket_public_access_block" "replica" {
    provider                        = aws.replica
    bucket                          = aws_s3_bucket.replica.id
    block_public_acls               = true
    block_public_policy             = true
    ignore_public_acls              = true
    restrict_public_buckets         = true
}

resource "aws_s3_bucket_policy" "state_force_ssl" {
    bucket                          = aws_s3_bucket.state.id
    policy                          = data.aws_iam_policy_document.state_force_ssl.json
    depends_on                      = [aws_s3_bucket_public_access_block.state]
}

resource "aws_s3_bucket_policy" "replica_force_ssl" {
    provider                        = aws.replica
    bucket                          = aws_s3_bucket.replica.id
    policy                          = data.aws_iam_policy_document.replica_force_ssl.json
    depends_on                      = [aws_s3_bucket_public_access_block.replica]
}
