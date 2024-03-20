variable "environment"              {}
variable "project_name"             {}

variable "cluster_version"          {}

variable "vpc_id"                   {}
variable "subnets"                  {
    type            = list(string)
}

variable "security_groups"          {
    type            = list
}

variable "cluster_enabled_log_types" {
    default         = []
    description     = "A list of the desired control plane logging to enable."
    type            = list(string)
}

variable "allowed_external_cidrs"    {
    description = "List of CIDRs than can access to the bastion. Default : 0.0.0.0/0"
    type        = list(string)

    default = [
        "0.0.0.0/0",
    ]
}
