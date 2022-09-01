variable "vpc_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "eks_version" {}
variable "name" {}
variable "redis_port" {}
