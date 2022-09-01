module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.name
  cluster_version = var.eks_version

  cluster_endpoint_private_access = false
  cluster_endpoint_public_access  = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cloudwatch_log_group_retention_in_days = 1

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["m5.large"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 2
      max_size     = 10
      desired_size = 2

      instance_types = ["m5.large"]
      capacity_type  = "SPOT"
    }
  }

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    redis_allow_access = {
      type        = "egress"
      protocol    = "tcp"
      from_port   = "${var.redis_port}"
      to_port     = "${var.redis_port}"
      description = "Allow Redis"
      cidr_blocks = ["0.0.0.0/0"]
    }
    msk_allow_access = {
      type        = "egress"
      protocol    = "tcp"
      from_port   = "9092"
      to_port     = "9092"
      description = "Allow Redis"
      cidr_blocks = ["0.0.0.0/0"]
    }
    mysql_allow_access = {
      type        = "egress"
      protocol    = "tcp"
      from_port   = "3306"
      to_port     = "3306"
      description = "Allow Mysql"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = var.name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    module.eks
  ]
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name      = var.name
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    module.eks
  ]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name      = var.name
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    module.eks
  ]
}
