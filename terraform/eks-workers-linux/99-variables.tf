variable "environment"                  {}
variable "project_name"                 {}

variable "cluster_ca"                   {}
variable "cluster_name"                 {}
variable "cluster_endpoint"             {}
variable "cluster_version"              {}

variable "workers_iam_profile_name"     {}
variable "workers_iam_role_arn"         {}

variable "workers_role_name"            {}
variable "workers_instance_type"        {}

variable "workers_asg_desired_capacity" {}
variable "workers_asg_max_size"         {}
variable "workers_asg_min_size"         {}

variable "subnets"                      {
    type            = list(string)
}

variable "ssh_key_name"                 {}

variable "security_groups"              {
    type            = list
}
