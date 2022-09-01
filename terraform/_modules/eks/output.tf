output "eks_cluster_certificate_authority_data" {
  description = "cluster_certificate_authority_data"
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_oidc_issuer_url" {
  description = "cluster_oidc_issuer_url"
  value       = module.eks.cluster_oidc_issuer_url
}

output "eks_cluster_endpoint" {
  description = "cluster_endpoint"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_id" {
  description = "cluster_id"
  value       = module.eks.cluster_id
}
