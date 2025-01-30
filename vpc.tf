resource "aws_vpc" "vpc-test" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc-test"
  }
}
