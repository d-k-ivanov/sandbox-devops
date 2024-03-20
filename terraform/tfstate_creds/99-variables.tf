variable "region"                   {}
variable "aws_access_key"           {}
variable "aws_secret_key"           {}
variable "project_name"             {}
variable "suffix"                   {}

# Security
variable "pgp_key"                  {}

# Enable or disable deploy of services
variable "is_s3_tfstate_handler"    {}
