output "vpc_id" {
  value = module.vpc.vpc_id
}
output "transit_gateway_id" {
  value = module.vpc.transit_gateway_id
}
output "transit_gateway_vpc_attachment_id" {
  value = module.vpc.transit_gateway_vpc_attachment_id
}
