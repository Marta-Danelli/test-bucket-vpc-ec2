resource "aws_instance" "server" {
    ami = var.ami_server
    instance_type = var.type_server
    subnet_id= var.subnet_id.private
    vpc_security_group_ids = [aws_security_group.private.id]
    tags = {
        Name = "private server"
    }
}

resource "aws_security_group" "private" {
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

}

resource "aws_instance" "public_server" {
    ami = var.ami_server
    instance_type = var.type_server
    subnet_id= var.subnet_id.public
    vpc_security_group_ids = [aws_security_group.public.id]
    tags = {
        Name = "public server"
    }
}

resource "aws_security_group" "public" {
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

}
