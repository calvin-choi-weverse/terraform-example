resource "aws_memorydb_cluster" "example" {
  acl_name                 = "open-access"
  name                     = var.name
  node_type                = var.node_type
  num_shards               = var.num_shards
  security_group_ids       = [aws_security_group.redis_security_group.id]
  snapshot_retention_limit = var.snapshot_retention_limit
  subnet_group_name        = aws_memorydb_subnet_group.subnet_group.id
  port                     = var.port
}

resource "aws_memorydb_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "redis_security_group" {
  name        = "${var.name}-security-group"
  description = "${var.name} MemoryDB Security Group"
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
