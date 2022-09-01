resource "aws_elasticache_replication_group" "replication_group" {
  replication_group_id       = "${var.cluster_id}-redis-cluster"
  description                = "${var.cluster_id}-redis-cluster"
  node_type                  = var.node_type
  port                       = var.port
  automatic_failover_enabled = true
  subnet_group_name          = aws_elasticache_subnet_group.subnet_group.id

  num_node_groups         = var.num_node_groups
  replicas_per_node_group = var.replicas_per_node_group
  security_group_ids      = [aws_security_group.redis_security_group.id]
}

resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "redis_security_group" {
  name        = "${var.cluster_id}-security-group"
  description = "${var.cluster_id} Redis Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
    description = "bootstrap port"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Internal outbound traffic"
  }
}
