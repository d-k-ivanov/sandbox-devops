output "aws_auth_roles" {
    description = "Roles for use in aws-auth ConfigMap"
    value = [
        {
            worker_role_arn = var.workers_iam_role_arn
            platform        = "linux"
        }
    ]
}
