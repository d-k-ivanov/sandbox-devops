variable "region"                           {}
variable "aws_access_key"                   {}
variable "aws_secret_key"                   {}
variable "environment"                      {}
variable "project_name"                     {}
variable "suffix"                           {}

variable "ssh_key_name"                     {}
variable "instance_type"                    {}
variable "subnet"                           {}

variable "security_groups"                  {
    type = list
}
