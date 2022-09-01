module "aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name           = var.name
  engine         = var.engine
  engine_version = var.engine_version
  instances      = var.instances

  vpc_id  = var.vpc_id
  subnets = var.subnets

  database_name = var.default_database_name

  create_security_group = true
  allowed_cidr_blocks   = [var.allowed_cidr_blocks]

  apply_immediately   = true
  skip_final_snapshot = true

  master_username = var.master_username
  master_password = var.master_password

  vpc_security_group_ids = [aws_security_group.mysql_security_group.id]
}

resource "aws_security_group" "mysql_security_group" {
  name        = "${var.name}-security-group"
  description = "${var.name} Mysql Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = "3306"
    to_port     = "3306"
    protocol    = "tcp"
    cidr_blocks = ["${var.allowed_cidr_blocks}"]
    description = "mysql inbound port"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "outbound port"
  }
}
