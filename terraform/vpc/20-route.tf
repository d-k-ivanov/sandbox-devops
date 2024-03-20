#---------------------------------------------------------------------------------------------------
# Routing
#---------------------------------------------------------------------------------------------------
resource "aws_route_table" "public" {
    vpc_id                      = aws_vpc.vpc.id
    tags = {
        Name                    = "${var.project_name}-${var.environment}-public-route-table"
        Terraform               = "True"
    }
}

resource "aws_route_table_association" "public_a" {
    subnet_id                   = aws_subnet.public_subnet_a.id
    route_table_id              = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
    subnet_id                   = aws_subnet.public_subnet_b.id
    route_table_id              = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
    route_table_id              = aws_route_table.public.id
    destination_cidr_block      = "0.0.0.0/0"
    gateway_id                  = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table" "private_a" {
    vpc_id                      = aws_vpc.vpc.id
    tags = {
        Name                    = "${var.project_name}-${var.environment}-private-route-table-a"
        Terraform               = "True"
    }
}

resource "aws_route_table_association" "private_a" {
    subnet_id                   = aws_subnet.private_subnet_a.id
    route_table_id              = aws_route_table.private_a.id
}

resource "aws_route" "private_a_nat_gateway" {
    route_table_id              = aws_route_table.private_a.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat_gateway_a.id
    depends_on                  = [aws_route_table.private_a]
}

resource "aws_route_table" "private_b" {
    vpc_id                      = aws_vpc.vpc.id
    tags = {
        Name                    = "${var.project_name}-${var.environment}-private-route-table-b"
        Terraform               = "True"
    }
}

resource "aws_route_table_association" "private_b" {
    subnet_id                   = aws_subnet.private_subnet_b.id
    route_table_id              = aws_route_table.private_b.id
}

resource "aws_route" "private_b_nat_gateway" {
    route_table_id              = aws_route_table.private_b.id
    destination_cidr_block      = "0.0.0.0/0"
    nat_gateway_id              = aws_nat_gateway.nat_gateway_b.id
    depends_on                  = [aws_route_table.private_b]
}
