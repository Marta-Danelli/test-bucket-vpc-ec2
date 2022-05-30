resource "aws_vpc" "vpc_test" {
  cidr_block = var.cidr_vpc
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc_test.id
  cidr_block = var.cidr_subnet.private

  tags = {
    Name = "private subnet"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc_test.id
  cidr_block = var.cidr_subnet.public

  tags = {
    Name = "public subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_test.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public route table"
  }
}

resource "aws_route_table_association" "public_route" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route.id
}


