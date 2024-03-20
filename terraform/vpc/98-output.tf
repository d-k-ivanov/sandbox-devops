output "vpc" {
    description                 = "VPC in region"
    value                       = aws_vpc.vpc
}

output "vpc_id" {
    description                 = "ID VPC in region"
    value                       = aws_vpc.vpc.id
}

output "public_subnet_a_id" {
    description                 = "ID of public subnet in AZ-a in region"
    value                       = aws_subnet.public_subnet_a.id
}

output "public_subnet_b_id" {
    description                 = "ID of public subnet in AZ-b in region"
    value                       = aws_subnet.public_subnet_b.id
}

output "private_subnet_a_id" {
    description                 = "ID of private subnet in AZ-a in region"
    value                       = aws_subnet.private_subnet_a.id
}

output "private_subnet_b_id" {
    description                 = "ID of private subnet in AZ-b in region"
    value                       = aws_subnet.private_subnet_b.id
}

output "region" {
    description                 = "VPC region"
    value                       = var.region
}
