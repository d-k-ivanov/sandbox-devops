variable "region" {
    type        = "string"
    description = "AWS region"
}

variable "project_name" {
    type        = "string"
    description = "project_name name"
}

variable "environment" {
    type        = "string"
    description = "Environment name - prod, dev, etc."
}

variable "sub_environment" {
    type        = "string"
    description = "Sub environment name - XXX, pas, etc."
}

variable "ecs_service_arn" {
    type        = "string"
    description = "ARN of ECS task"
}

variable "service_name" {
    type        = "string"
    description = "Name of ECS task"
}

variable "service_count" {
    description = "Number of containers"
}

variable "service_port" {
    description = "Port of ECS task"
}

variable "service_version" {
    type        = "string"
    description = "Version of service - aka image tag"
}

variable "ecs_cluster_arn" {
    type        = "string"
    description = "ARN of ECS cluster"
}

variable "ecs_listener_arn" {
    type        = "string"
    description = "LB Listener ARN"
}

variable "path_pattern" {
    type        = "list"
    description = "Path patternt for ALB rule"
}

variable "path_pattern_count" {
    description = "Number of patternts for ALB rule"
}

variable "listener_rule_priority" {
    description = "Listener host priority"
}

variable "health_check_path" {
    type        = "string"
    description = "Path for Target Group healthcheck"
}

variable "dns_suffix" {
    type = "string"
    description = "DNS suffix"
}

variable "vpc_id" {
    type        = "string"
    description = "VPC ID"
}

variable "ecs_discovery_private_namespace_id" {
    type        = "string"
    description = "ARN of ECS service discovery namespace id"
}

variable "ecs_service_security_groups" {
    type        = "list"
    description = "List of service security groups"
}

variable "private_subnets" {
    type        = "list"
    description = "List of private VPC subnets"
}
