module "vpc_practice" {
  source = "./_modules/vpc"

  name     = "${var.prefix}-vpc"
  vpc_cidr = var.vpc_cidr

  az              = ["ap-northeast-2a", "ap-northeast-2c"]
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # https://aws.amazon.com/ko/premiumsupport/knowledge-center/eks-load-balancer-controller-subnets/
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = "1"
  }
}

module "eks_practice" {
  source = "./_modules/eks"

  name        = var.eks_cluster_name
  eks_version = "1.22"

  vpc_id          = module.vpc_practice.vpc_id
  private_subnets = module.vpc_practice.private_subnets
  redis_port      = var.redis_port
}

module "msk_practice" {
  source = "./_modules/msk"

  name          = "${var.prefix}-msk"
  kafka_version = "2.6.2"

  private_subnets = module.vpc_practice.private_subnets
  vpc_id          = module.vpc_practice.vpc_id
  vpc_cidr_block  = module.vpc_practice.vpc_cidr_block
}

module "s3_practice" {
  source = "./_modules/s3"

  aws_region = var.aws_region
  name       = "${var.prefix}-s3"

  vpc_id                      = module.vpc_practice.vpc_id
  vpc_private_route_table_ids = module.vpc_practice.vpc_private_route_table_ids
}

module "dynamodb_practice" {
  source = "./_modules/dynamodb"

  aws_region = var.aws_region

  vpc_id                      = module.vpc_practice.vpc_id
  vpc_private_route_table_ids = module.vpc_practice.vpc_private_route_table_ids
}

module "codebuild_practice" {
  source              = "./_modules/codebuild_ecr"
  aws_region          = var.aws_region
  account_id          = var.account_id
  codebuild_name      = "${var.prefix}-codebuild"
  github_repo         = var.github_repo
  image_tag           = var.image_tag
  source_version      = var.source_version
  ecr_repository_name = "${var.prefix}-ecr"
}

module "cache_redis_practice" {
  source                  = "./_modules/cache"
  cluster_id              = "${var.prefix}-cache-redis"
  num_node_groups         = "2"
  replicas_per_node_group = "1"
  port                    = var.redis_port
  node_type               = "cache.m4.large"
  subnet_ids              = module.vpc_practice.private_subnets
  vpc_id                  = module.vpc_practice.vpc_id
  vpc_cidr_block          = module.vpc_practice.vpc_cidr_block
  subnet_group_name       = "${var.prefix}-cache-redis-subnet-group"
}

module "memorydb_redis_practice" {
  source                   = "./_modules/memorydb"
  name                     = "${var.prefix}-memorydb-redis"
  node_type                = "db.t4g.small"
  num_shards               = "2"
  snapshot_retention_limit = "7"
  port                     = "6379"
  subnet_group_name        = "${var.prefix}-memorydb-redis-subnet-group"
  subnet_ids               = module.vpc_practice.private_subnets
  vpc_id                   = module.vpc_practice.vpc_id
  vpc_cidr_block           = module.vpc_practice.vpc_cidr_block
}

module "rds_aurora_practice" {
  source         = "./_modules/rds"
  name           = "${var.prefix}-rds-aurora"
  engine         = "aurora-mysql"
  engine_version = "5.7"
  instances = {
    1 = {
      instance_class = "db.r5.large"
    }
    2 = {
      identifier     = "mysql-static-1"
      instance_class = "db.r5.2xlarge"
    }
  }
  vpc_id              = module.vpc_practice.vpc_id
  subnets             = module.vpc_practice.private_subnets
  allowed_cidr_blocks = module.vpc_practice.vpc_cidr_block

  default_database_name = var.rds_aurora_default_database_name

  master_username = var.rds_aurora_master_name
  master_password = var.rds_aurora_master_password
}

module "secretsmanager_practice" {
  source = "./_modules/secretsmanager"
  name   = "${var.prefix}-secretmanager"
}
