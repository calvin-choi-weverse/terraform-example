output "vpc_id" {
  description = "cluster_id"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "cidr_block"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "subnetIds"
  value       = module.vpc.private_subnets
}

output "vpc_private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}
