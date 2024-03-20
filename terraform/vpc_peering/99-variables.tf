variable "aws_region_this"          {}
variable "aws_region_peer"          {}
variable "aws_access_key"           {}
variable "aws_secret_key"           {}
variable "environment"              {}
variable "project_name"             {}

variable "tags" {
    description = "A mapping of tags to assign to resources."
    default = {
        Terraform               = "True"
    }
}

variable "this_vpc_id"              {}
variable "peer_vpc_id"              {}

variable "auto_accept_peering" {
    description             = "Auto accept peering connection: bool"
    type                    = bool
    default                 = false
}

variable "this_dns_resolution" {
    description             = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a this VPC"
    type                    = bool
    default                 = false
}

variable "peer_dns_resolution" {
    description             = "Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC"
    type                    = bool
    default                 = false
}

variable "this_link_to_peer_classic" {
    description             = "Indicates whether a local ClassicLink connection can communicate with the this VPC over the VPC Peering Connection"
    type                    = bool
    default                 = false
}

variable "peer_link_to_peer_classic" {
    description             = "Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC Peering Connection"
    type                    = bool
    default                 = false
}

variable "this_link_to_local_classic" {
    description             = "Indicates whether a local VPC can communicate with a ClassicLink connection in the this VPC over the VPC Peering Connection"
    type                    = bool
    default                 = false
}

variable "peer_link_to_local_classic" {
    description             = "Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC Peering Connection"
    type                    = bool
    default                 = false
}

variable "from_this" {
    description             = "If traffic TO peer vpc (from this) should be allowed"
    type                    = bool
    default                 = true
}

variable "from_peer" {
    description             = "If traffic FROM peer vpc (to this) should be allowed"
    type                    = bool
    default                 = true
}

variable "this_subnets_ids" {
    description             = "If communication can only go to some specific subnets of this vpc. If empty whole vpc cidr is allowed"
    type                    = list(string)
    default                 = []
}

variable "peer_subnets_ids" {
    description             = "If communication can only go to some specific subnets of peer vpc. If empty whole vpc cidr is allowed"
    type                    = list(string)
    default                 = []
}

variable "this_rts_ids" {
    description             = "Allows to explicitly specify route tables for this VPC"
    type                    = list(string)
    default                 = []
}

variable "peer_rts_ids" {
    description             = "Allows to explicitly specify route tables for peer VPC"
    type                    = list(string)
    default                 = []
}
