variable "environment"              {}
variable "project_name"             {}
variable "vpc_id"                   {}

variable "allowed_external_cidrs"    {
    description = "List of CIDRs than can access to the bastion. Default : 0.0.0.0/0"
    type        = list(string)

    default = [
        "0.0.0.0/0",
    ]
}
