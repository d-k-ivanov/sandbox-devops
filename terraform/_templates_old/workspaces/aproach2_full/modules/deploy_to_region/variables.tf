# Main
variable "region"               {}
variable "environment"          {}
variable "project_name"         {}

# DNS
variable "dns_zone_id"          {}
variable "dns_suffix"           {}

# ECS
variable "capacity_min"         {}
variable "capacity_max"         {}
variable "capacity_desired"     {}
variable "ecs_optimized_ami"    {}
variable "instance_size"        {}

# Network
variable "vpc_id"               {}
variable "public_subnet_a"      {}
variable "public_subnet_b"      {}
variable "private_subnet_a"     {}
variable "private_subnet_b"     {}

# Security
variable "ssh_key_pair"         {}
variable "ssl_certificate_arn"  {}

# Extra
variable "sg_extra_vpn"         {}
variable "sg_extra_rds"         {}
