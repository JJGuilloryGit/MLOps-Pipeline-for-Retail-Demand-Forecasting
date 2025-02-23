output "eks_cluster_name" {
  value = aws_eks_cluster.mlops_cluster.name
}

output "s3_bucket" {
  value = aws_s3_bucket.mlops_data_bucket.bucket
}

output "kafka_brokers" {
  value = aws_msk_cluster.mlops_kafka.bootstrap_brokers
}
