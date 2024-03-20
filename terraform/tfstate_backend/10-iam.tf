#---------------------------------------------------------------------------------------------------
# IAM Policy for Terraform remote state
#---------------------------------------------------------------------------------------------------
resource "aws_iam_policy" "tfstate_backend_policy" {
    name                = "${var.project_name}-${var.environment}-tfstate"
    policy              = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "${aws_s3_bucket.state.arn}"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "${aws_s3_bucket.state.arn}/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": "${aws_dynamodb_table.tfstate_backend_locks.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:ListKeys"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:GenerateDataKey"
      ],
      "Resource": "${aws_kms_key.this.arn}"
    }
  ]
}
POLICY
}

#---------------------------------------------------------------------------------------------------
# IAM Role for Replication
#---------------------------------------------------------------------------------------------------
resource "aws_iam_role" "tfstate_backend_replica_role" {
    name                = "${var.project_name}-${var.environment}-tfstate-replica"
    assume_role_policy  = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY

    tags =  merge(
        var.tags,
        {
            Project                 = var.project_name
            Environment             = var.environment
        },
    )
}

resource "aws_iam_policy" "tfstate_backend_replica_policy" {
    name                = "${var.project_name}-${var.environment}-tfstate-replica"
    policy              = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.state.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersionForReplication",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.state.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.replica.arn}/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "${aws_kms_key.this.arn}",
      "Condition": {
        "StringLike": {
          "kms:ViaService": "s3.${data.aws_region.state.name}.amazonaws.com",
          "kms:EncryptionContext:aws:s3:arn": [
            "${aws_s3_bucket.state.arn}/*"
          ]
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:GenerateDataKey"
      ],
      "Resource": "${aws_kms_key.replica.arn}",
      "Condition": {
        "StringLike": {
          "kms:ViaService": "s3.${data.aws_region.replica.name}.amazonaws.com",
          "kms:EncryptionContext:aws:s3:arn": [
            "${aws_s3_bucket.replica.arn}/*"
          ]
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tfstate_backend_policy_attachment_replica" {
    role                = aws_iam_role.tfstate_backend_replica_role.name
    policy_arn          = aws_iam_policy.tfstate_backend_replica_policy.arn
}

#---------------------------------------------------------------------------------------------------
# Bucket Policies
#---------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "state_force_ssl" {
    statement {
        sid     = "AllowSSLRequestsOnly"
        actions = ["s3:*"]
        effect  = "Deny"
        resources = [
            aws_s3_bucket.state.arn,
            "${aws_s3_bucket.state.arn}/*"
        ]
        condition {
            test     = "Bool"
            variable = "aws:SecureTransport"
            values   = ["false"]
        }
        principals {
            type        = "*"
            identifiers = ["*"]
        }
    }
}

data "aws_iam_policy_document" "replica_force_ssl" {
    statement {
        sid     = "AllowSSLRequestsOnly"
        actions = ["s3:*"]
        effect  = "Deny"
        resources = [
            aws_s3_bucket.replica.arn,
            "${aws_s3_bucket.replica.arn}/*"
        ]
        condition {
            test     = "Bool"
            variable = "aws:SecureTransport"
            values   = ["false"]
        }
        principals {
            type        = "*"
            identifiers = ["*"]
        }
    }
}
