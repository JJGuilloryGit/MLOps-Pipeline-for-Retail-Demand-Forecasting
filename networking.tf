resource "aws_vpc" "mlops_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mlops_subnet" {
  count             = 2
  vpc_id           = aws_vpc.mlops_vpc.id
  cidr_block       = "10.0.${count.index}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
}

resource "aws_security_group" "mlops_sg" {
  vpc_id = aws_vpc.mlops_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "vpc_id" {
  value = aws_vpc.mlops_vpc.id
}

output "subnets" {
  value = aws_subnet.mlops_subnet[*].id
}
