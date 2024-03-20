#---------------------------------------------------------------------------------------------------
# Gateway settings
#---------------------------------------------------------------------------------------------------
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id                      = aws_vpc.vpc.id
    tags = {
        Name                    = "${var.project_name}-${var.environment}-internet-gateway"
        Terraform               = "True"
    }
}

resource "aws_eip" "nat_gateway_ip_a" {
    vpc                         = true

    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-nat-ip-a"
        Terraform               = "True"
    }
}

resource "aws_nat_gateway" "nat_gateway_a" {
    allocation_id               = aws_eip.nat_gateway_ip_a.id
    subnet_id                   = aws_subnet.public_subnet_a.id
    depends_on                  = [aws_internet_gateway.internet_gateway]

    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-nat-gw-a"
        Terraform               = "True"
    }
}

resource "aws_eip" "nat_gateway_ip_b" {
    vpc                         = true

    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-nat-ip-b"
        Terraform               = "True"
    }
}

resource "aws_nat_gateway" "nat_gateway_b" {
    allocation_id               = aws_eip.nat_gateway_ip_b.id
    subnet_id                   = aws_subnet.public_subnet_b.id
    depends_on                  = [aws_internet_gateway.internet_gateway]

    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-nat-gw-b"
        Terraform               = "True"
    }
}
