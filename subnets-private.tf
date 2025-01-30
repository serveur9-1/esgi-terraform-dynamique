resource "aws_subnet" "private_subnet" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }

  vpc_id     = aws_vpc.vpc-test.id
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.all_az.names[each.key]

  tags = {
    Name = "subnet-private-${each.key + 1}"
  }
}


resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}


resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route.id
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.private_subnet[0].id 

  tags = {
    Name = "NAT-Gateway"
  }

  depends_on = [aws_internet_gateway.gw-public]
}


resource "aws_eip" "eip_nat" {
  domain = "vpc"
}
