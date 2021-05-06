resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "project-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "project-gw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "project-route-table"
  }
}

resource "aws_default_route_table" "private_route" {
    count = length(var.private_cidr) > 0 ? 1 : 0
    default_route_table_id = aws_vpc.main.default_route_table_id
    route {
        nat_gateway_id = aws_nat_gateway.ngw[count.index]
        cidr_block = "0.0.0.0/0"
    }
    tags = {
        Name = "private-project-route-table"
    }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_cidr, count.index)
  availability_zone = element(var.subnet_azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "project-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_cidr)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_cidr, count.index)
  availability_zone = element(var.subnet_azs, count.index)
  tags = {
    Name = "private-project-subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_association" {
  count = length(var.public_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_association" {
  count = length(var.private_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_default_route_table.private_route[count.index]
}

resource "aws_eip" "eip" {
    count = length(var.private_cidr) > 0 ? 1 : 0
    vpc = true
}

resource "aws_nat_gateway" "ngw" {
    count = length(var.private_cidr) > 0 ? 1 : 0
    allocation_id = aws_eip.eip[count.index]
    subnet_id = aws_subnet.public_subnet.0.id
}

