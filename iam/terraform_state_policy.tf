resource "aws_iam_policy" "terraform_state" {
  name        = "terraform-state-access"
  description = "Policy for accessing Terraform state bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ]
        Resource = [
          "arn:aws:s3:::awsaibucket1"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:AbortMultipartUpload",
          "s3:ListMultipartUploadParts"
        ]
        Resource = [
          "arn:aws:s3:::awsaibucket1",
        ]
      }
    ]
  })
}

# Attach the policy to your IAM user
resource "aws_iam_user_policy_attachment" "terraform_state" {
  user       = "jjguilloryuser1"  # I see this is already set to your username
  policy_arn = aws_iam_policy.terraform_state.arn
}
