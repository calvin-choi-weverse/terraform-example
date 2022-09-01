variable "name" {}
variable "vpc_cidr" {}
variable "az" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnet_tags" {}
variable "private_subnet_tags" {}
