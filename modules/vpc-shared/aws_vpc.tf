resource "aws_vpc" "this" {
  cidr_block           = "10.100.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.app_name}"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = [aws_subnet.private_a.id, aws_subnet.private_c.id]
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = aws_vpc.this.id

  dns_support                                     = "enable"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${var.app_name}"
  }
}
