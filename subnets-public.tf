resource "aws_subnet" "public_subnet" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }

  vpc_id            = aws_vpc.vpc-test.id
  cidr_block        = each.value
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.all_az.names[each.key]

  tags = {
    Name = "subnet-public-${each.key + 1}"
  }
}




resource "aws_internet_gateway" "gw-public" {
  vpc_id = aws_vpc.vpc-test.id

  tags = {
    Name = "Internet-Gateway"
  }
}


resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc-test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-public.id
  }
}



resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route.id
}

