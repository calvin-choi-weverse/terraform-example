resource "aws_msk_cluster" "cluster" {
  cluster_name           = var.name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = 2

  configuration_info {
    arn      = aws_msk_configuration.msk_configuration.arn
    revision = 1
  }

  broker_node_group_info {
    instance_type  = "kafka.m5.large"
    client_subnets = var.private_subnets
    storage_info {
      ebs_storage_info {
        volume_size = 10
      }
    }
    security_groups = [aws_security_group.broker.id]
  }

  client_authentication {
    unauthenticated = true
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
      in_cluster    = false
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.cloudwatch_log_group.name
      }
    }
  }
}

resource "aws_security_group" "broker" {
  name        = "${var.name}-${var.vpc_id}"
  description = "${var.name} MSK Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9092
    to_port     = 9092
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

resource "aws_msk_configuration" "msk_configuration" {
  kafka_versions = [var.kafka_version]
  name           = var.name

  server_properties = <<PROPERTIES
allow.everyone.if.no.acl.found=true
auto.create.topics.enable=true
default.replication.factor=2
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=4
num.replica.fetchers=2
replica.lag.time.max.ms=30000
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
socket.send.buffer.bytes=102400
unclean.leader.election.enable=true
zookeeper.session.timeout.ms=18000
PROPERTIES
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "${var.name}-msk_broker_logs"
}
