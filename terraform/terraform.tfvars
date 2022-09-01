# region
aws_region = "ap-northeast-2"
account_id          = "692609349536"
redis_port = "6379"

## 변수 변경할 내역들
# name prefix
prefix = "prefix"
eks_cluster_name    = "eks-practice"
github_repo         = "https://github.com/hyungeunjo8/eks-fargate-practice"
image_tag           = "latest"
source_version      = "develop"
vpc_cidr = "10.196.0.0/16"
public_subnets = ["10.196.0.0/24", "10.196.1.0/24"]
private_subnets = ["10.196.100.0/24", "10.196.101.0/24"]
rds_aurora_default_database_name = "practice"
rds_aurora_master_name = "root"
rds_aurora_master_password = "temppassword1234%^&*"