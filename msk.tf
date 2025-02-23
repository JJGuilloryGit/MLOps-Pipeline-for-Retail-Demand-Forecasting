resource "aws_msk_cluster" "mlops_kafka" {
  cluster_name           = "mlops-msk-cluster"
  kafka_version          = "2.8.0"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    ebs_volume_size = 100
    client_subnets  = var.subnets
    security_groups = [aws_security_group.mlops_sg.id]
  }
}

output "msk_bootstrap_brokers" {
  value = aws_msk_cluster.mlops_kafka.bootstrap_brokers
}
