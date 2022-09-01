resource "aws_s3_bucket" "bucket" {
  bucket = var.name
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_routetable" {
  count           = length(var.vpc_private_route_table_ids)
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = var.vpc_private_route_table_ids[count.index]
}
