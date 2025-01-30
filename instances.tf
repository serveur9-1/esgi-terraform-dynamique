resource "aws_instance" "instance_1" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "Instance 1"
  }
}
