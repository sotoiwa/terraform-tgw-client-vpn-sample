resource "aws_ec2_client_vpn_endpoint" "this" {
  vpc_id                 = aws_vpc.this.id
  server_certificate_arn = var.server_certificate.arn
  client_cidr_block      = "100.64.0.0/22"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.root_certificate.arn
  }

  split_tunnel = true

  security_group_ids = [
    aws_security_group.client_vpn_endpoint.id
  ]

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.client_vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.client_vpn.name
  }

  tags = {
    Name = "${var.app_name}-client-vpn-endpoint"
  }
}

resource "aws_cloudwatch_log_group" "client_vpn" {
  name = "/aws/client-vpn"

}

resource "aws_cloudwatch_log_stream" "client_vpn" {
  name           = "connection-log"
  log_group_name = aws_cloudwatch_log_group.client_vpn.name
}

resource "aws_ec2_client_vpn_network_association" "private_a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = aws_subnet.private_a.id
}

resource "aws_ec2_client_vpn_network_association" "private_c" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id              = aws_subnet.private_c.id
}

resource "aws_ec2_client_vpn_authorization_rule" "this" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = "10.100.0.0/16"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "migration" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = "10.0.0.0/16"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "dev" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  target_network_cidr    = "10.1.0.0/16"
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "migration_a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "10.0.0.0/16"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_a.subnet_id
}

resource "aws_ec2_client_vpn_route" "migration_c" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "10.0.0.0/16"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_c.subnet_id
}

resource "aws_ec2_client_vpn_route" "dev_a" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "10.1.0.0/16"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_a.subnet_id
}

resource "aws_ec2_client_vpn_route" "dev_c" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  destination_cidr_block = "10.1.0.0/16"
  target_vpc_subnet_id   = aws_ec2_client_vpn_network_association.private_c.subnet_id
}
