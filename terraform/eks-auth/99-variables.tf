# variable "environment"              {}
# variable "project_name"             {}

# variable "cluster_ca"               {}
# variable "cluster_name"             {}
# variable "cluster_endpoint"         {}
# variable "cluster_version"          {}

variable "aws_auth_roles" {
    description = "A list of aws auth roles for configmap creation"
    type = list(object({
        worker_role_arn = string
        platform        = string
    }))
}

variable "aws_auth_additional_labels" {
    description = "Additional kubernetes labels applied on aws-auth ConfigMap"
    default = {}
    type = map(string)
}

variable "map_accounts" {
    description = "Additional AWS account numbers to add to the aws-auth configmap."
    type = list(string)
    default = []
}

variable "map_users" {
    description = "Additional IAM users to add to the aws-auth configmap."
    type = list(object({
        userarn  = string
        username = string
        groups   = list(string)
    }))
    default = []
}

variable "map_roles" {
    description = "Additional IAM roles to add to the aws-auth configmap."
    type = list(object({
        rolearn  = string
        username = string
        groups   = list(string)
    }))
    default = []
}
