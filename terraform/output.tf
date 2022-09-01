output "vpc_id" {
  description = "vpc_id"
  value       = module.vpc_practice.vpc_id
}

output "eks_cluster_certificate_authority_data" {
  description = "cluster_certificate_authority_data"
  value       = module.eks_practice.eks_cluster_certificate_authority_data
}

output "eks_cluster_oidc_issuer_url" {
  description = "cluster_oidc_issuer_url"
  value       = module.eks_practice.eks_cluster_oidc_issuer_url
}

output "eks_cluster_endpoint" {
  description = "cluster_endpoint"
  value       = module.eks_practice.eks_cluster_endpoint
}

output "eks_cluster_id" {
  description = "cluster_id"
  value       = module.eks_practice.eks_cluster_id
}
