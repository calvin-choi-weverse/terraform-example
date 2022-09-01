module "alb_practice" {
  source = "./_modules/alb"

  aws_region = var.aws_region
  account_id = var.account_id

  lb_controller_policy_name_prefix   = "AWSLoadBalancerControllerIAMPolicy"
  lb_controller_image_url            = "602401143452.dkr.ecr.ap-northeast-2.amazonaws.com/amazon/aws-load-balancer-controller"
  lb_controller_iam_role_name        = "inhouse-eks-terraform-practice-aws-lb-ctrl"
  lb_controller_service_account_name = "aws-load-balancer-controller"

  eks_cluster_endpoint                   = data.terraform_remote_state.eks.outputs.eks_cluster_endpoint
  eks_cluster_certificate_authority_data = data.terraform_remote_state.eks.outputs.eks_cluster_certificate_authority_data
  eks_cluster_id                         = data.terraform_remote_state.eks.outputs.eks_cluster_id
  vpc_id                                 = data.terraform_remote_state.eks.outputs.vpc_id
  eks_cluster_oidc_issuer_url            = data.terraform_remote_state.eks.outputs.eks_cluster_oidc_issuer_url
}

module "service_account_practice" {
  source = "./_modules/serviceaccount"

  aws_region = var.aws_region
  account_id = var.account_id

  eks_cluster_id              = data.terraform_remote_state.eks.outputs.eks_cluster_id
  eks_cluster_oidc_issuer_url = data.terraform_remote_state.eks.outputs.eks_cluster_oidc_issuer_url

  eks_service_account_policy = var.eks_service_account_policy
}
