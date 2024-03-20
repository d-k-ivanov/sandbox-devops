locals {
    configmap_roles = [
        for role in var.aws_auth_roles :
        {
            # Work around https://github.com/kubernetes-sigs/aws-iam-authenticator/issues/153
            # Strip the leading slash off so that Terraform doesn't think it's a regex
            rolearn  = replace(role["worker_role_arn"], replace("/", "/^//", ""), "")
            username = role["platform"] == "fargate" ? "system:node:{{SessionName}}" : "system:node:{{EC2PrivateDNSName}}"
            groups = tolist(concat(
              [
                "system:bootstrappers",
                "system:nodes",
              ],
              role["platform"] == "windows" ? ["eks:kube-proxy-windows"] : [],
              role["platform"] == "fargate" ? ["system:node-proxier"] : [],
            ))
        }
    ]
}
