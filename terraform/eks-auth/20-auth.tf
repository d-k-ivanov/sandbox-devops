resource "kubernetes_config_map" "aws_auth" {
    # depends_on = [data.http.wait_for_cluster]

    metadata {
        name      = "aws-auth"
        namespace = "kube-system"
        labels = merge(
            {
                "app.kubernetes.io/managed-by" = "Terraform"
                "terraform.io/module" = "eks-auth"
            },
            var.aws_auth_additional_labels
        )
    }

    data = {
        mapRoles = yamlencode(
            distinct(concat(
                local.configmap_roles,
                var.map_roles,
            ))
        )
        mapUsers    = yamlencode(var.map_users)
        mapAccounts = yamlencode(var.map_accounts)
    }
}
