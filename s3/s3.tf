resource "aws_s3_bucket" "awsaibucketdatacollection" {
  bucket = "awsaibucketdatacollection"
}

# Instead of using ACL, use bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.awsaibucketdatacollection.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Configure ACL (only after ownership is configured)
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]
  
  bucket = aws_s3_bucket.awsaibucketdatacollection.id
  acl    = "private"
}

# Optional: Configure public access block
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket = aws_s3_bucket.awsaibucketdatacollection.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Optional: Enable versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.awsaibucketdatacollection.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Optional: Enable server-side encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.awsaibucketdatacollection.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
