resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"
}

resource "aws_vpc_endpoint_route_table_association" "dynamo_endpoint_routetable" {
  count           = length(var.vpc_private_route_table_ids)
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
  route_table_id  = var.vpc_private_route_table_ids[count.index]
}
