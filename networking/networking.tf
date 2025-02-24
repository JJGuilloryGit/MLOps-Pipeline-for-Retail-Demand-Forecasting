resource "aws_vpc" "mlops_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mlops_subnet" {
  count             = 3
  vpc_id           = aws_vpc.mlops_vpc.id
  cidr_block       = "10.0.${count.index}.0/24"
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  
  tags = {
    Name = "mlops-subnet-${count.index + 1}"
  }
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

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_cluster" "mlops_eks" {
  name     = "mlops-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = aws_subnet.mlops_subnet[*].id
    security_group_ids = [aws_security_group.mlops_sg.id]
  }
}

output "vpc_id" {
  value = aws_vpc.mlops_vpc.id
}

output "subnets" {
  value = aws_subnet.mlops_subnet[*].id
}

output "eks_cluster_id" {
  value = aws_eks_cluster.mlops_eks.id
}
