resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.this.id
  service_name    = "com.amazonaws.${data.aws_region.this.name}.s3"
  route_table_ids = [aws_route_table.this.id]
}
