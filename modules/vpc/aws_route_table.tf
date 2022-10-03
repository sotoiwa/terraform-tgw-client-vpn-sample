resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block         = "10.100.0.0/16"
    transit_gateway_id = var.transit_gateway_id
  }

  tags = {
    Name = "${var.app_name}-route-table"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route_table_association" "isolated_a" {
  subnet_id      = aws_subnet.isolated_a.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route_table_association" "isolated_c" {
  subnet_id      = aws_subnet.isolated_c.id
  route_table_id = aws_route_table.this.id
}
