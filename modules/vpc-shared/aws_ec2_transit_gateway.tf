resource "aws_ec2_transit_gateway" "this" {
  dns_support                     = "enable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = "${var.app_name}-tgw"
  }
}

# ルートテーブル 1
resource "aws_ec2_transit_gateway_route_table" "table_1" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = {
    Name = "${var.app_name}-route-table-1"
  }
}

# ルートテーブル 2
resource "aws_ec2_transit_gateway_route_table" "table_2" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id

  tags = {
    Name = "${var.app_name}-route-table-2"
  }
}

# ルートテーブル 1 の関連付け
resource "aws_ec2_transit_gateway_route_table_association" "shared" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_1.id
}

# ルートテーブル 1 の伝播
resource "aws_ec2_transit_gateway_route_table_propagation" "migration" {
  transit_gateway_attachment_id  = var.vpc_migration_tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "dev" {
  transit_gateway_attachment_id  = var.vpc_dev_tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_1.id
}

# ルートテーブル 2 の関連付け
resource "aws_ec2_transit_gateway_route_table_association" "migration" {
  transit_gateway_attachment_id  = var.vpc_migration_tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_2.id
}

resource "aws_ec2_transit_gateway_route_table_association" "dev" {
  transit_gateway_attachment_id  = var.vpc_dev_tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_2.id
}

# ルートテーブル 2 の伝播
resource "aws_ec2_transit_gateway_route_table_propagation" "shared" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.table_2.id
}
