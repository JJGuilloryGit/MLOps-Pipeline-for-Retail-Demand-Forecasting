resource "aws_s3_bucket" "mlops_data_bucket" {
  bucket = "mlops-data-storage"
  acl    = "private"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.mlops_data_bucket.bucket
}
