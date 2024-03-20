variable "environment"              {}
variable "project_name"             {}

variable "vpc_id"                   {}
variable "subnets_public"           {
    type = list
}

variable "dns_zone_id"              {}
variable "dns_zone_name"            {}

variable "ssh_key_name"             {}

variable "security_groups"          {
    type = list
}

variable "bastion_instance_count"   {
    default = 1
}
