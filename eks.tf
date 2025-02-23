resource "aws_eks_cluster" "mlops_cluster" {
  name     = "mlops-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnets
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })
}
