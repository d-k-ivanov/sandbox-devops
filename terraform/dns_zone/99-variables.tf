variable "region"                   {}
variable "aws_access_key"           {}
variable "aws_secret_key"           {}
variable "environment"              {}
variable "project_name"             {}
variable "domain_name"              {}

variable "vpc_main"                 {}
variable vpc_others                 {
    type = list
}

