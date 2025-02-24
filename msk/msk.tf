resource "aws_msk_cluster" "kafka" {
  cluster_name           = "msk-cluster"
  kafka_version         = "2.8.1"  # Use appropriate version
  number_of_broker_nodes = 3

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    client_subnets  = var.subnets
    security_groups = [aws_security_group.kafka.id]
  }

  # Add other configuration as needed
}

resource "aws_security_group" "kafka" {
  name_prefix = "kafka-sg"
  vpc_id      = var.vpc_id

  # Add your security group rules here
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Modify as per your security requirements
  }
}