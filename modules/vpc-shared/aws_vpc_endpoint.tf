# ゲートウェイ型 VPC エンドポイント
resource "aws_vpc_endpoint" "s3" {
  vpc_id          = aws_vpc.this.id
  service_name    = "com.amazonaws.${data.aws_region.this.name}.s3"
  route_table_ids = [aws_route_table.this.id]
}

# インターフェース型 VPC エンドポイント

locals {
  services = [
    "sts",
    "ec2",
    "ec2messages",
    "ssm",
    "ssmmessages",
    "monitoring",
    "logs"
  ]
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.services)

  vpc_id            = aws_vpc.this.id
  service_name      = "com.amazonaws.${data.aws_region.this.name}.${each.key}"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.vpc_endpoints.id
  ]

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_c.id
  ]

  private_dns_enabled = false
}
