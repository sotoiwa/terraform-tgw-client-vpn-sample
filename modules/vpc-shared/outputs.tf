output "vpc_id" {
  value = aws_vpc.this.id
}
output "private_subnet_a_id" {
  value = aws_subnet.private_a.id
}
output "private_subnet_c_id" {
  value = aws_subnet.private_c.id
}
output "security_group_client_vpn_endpoint_id" {
  value = aws_security_group.client_vpn_endpoint.id
}
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}
output "transit_gateway_vpc_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.id
}
