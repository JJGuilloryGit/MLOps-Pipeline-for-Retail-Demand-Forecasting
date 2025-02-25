output "eks_cluster_name" {
  value = aws_eks_cluster.mlops-cluster.name
}

output "s3_bucket" {
  value = aws_s3_bucket.awsaibucketdatacollection.bucket
}

output "kafka_brokers" {
  value = aws_msk_cluster.mlops_kafka.bootstrap_brokers
}

output "jenkins_instance_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster API server"
  value       = aws_eks_cluster.mlops_eks_cluster.endpoint
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.mlops_eks_cluster.arn
}


output "cluster_certificate_authority" {
  description = "The base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.aws_eks_cluster.certificate_authority[0].data
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = aws_eks_cluster.aws_eks_cluster.version
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = aws_eks_cluster.aws_eks_cluster.vpc_config[0].cluster_security_group_id
}
