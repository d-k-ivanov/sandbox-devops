locals {
    config_map_aws_auth = <<CONFIGMAPAWSAUTH

apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.workers.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH
}

output "worker_role_arn" {
    description = "Worker Role ARN"
    value = aws_iam_role.workers.arn
}

output "worker_role_name" {
    description = "Worker Role Name"
    value = aws_iam_role.workers.name
}

output "worker_instance_profile_arn" {
    description = "Worker Role ARN"
    value = aws_iam_instance_profile.workers.arn
}

output "worker_instance_profile_name" {
    description = "Worker Role ARN"
    value = aws_iam_instance_profile.workers.name
}

output "config_map_aws_auth" {
    description = "Worker Auth Config Map"
    value = local.config_map_aws_auth
}
