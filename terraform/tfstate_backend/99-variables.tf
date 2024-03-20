#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------
variable "project_name"             {}
variable "environment"              {}

variable "tags" {
    description = "A mapping of tags to assign to resources."
    default = {
        Terraform               = "True"
    }
}

variable "noncurrent_version_transitions" {
    description = "Specifies when noncurrent object versions transitions. See the aws_s3_bucket document for detail."

    type = list(object({
        days          = number
        storage_class = string
    }))

    default = [
        {
            days          = 7
            storage_class = "GLACIER"
        }
    ]
}

variable "noncurrent_version_expiration" {
    description = "Specifies when noncurrent object versions expire. See the aws_s3_bucket document for detail."

    type = object({
        days = number
    })

    default = null
}
