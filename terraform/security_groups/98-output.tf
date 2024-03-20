output "internal_sg" {
    value = aws_security_group.internal_sg.id
}

output "eks_cluster_sg" {
    value = aws_security_group.eks_cluster_sg.id
}

output "eks_workers_sg" {
    value = aws_security_group.eks_workers_sg.id
}

output "bastion_sg" {
    value = aws_security_group.bastion_sg.id
}
