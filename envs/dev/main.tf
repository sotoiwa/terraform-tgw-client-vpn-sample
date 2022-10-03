module "vpc" {
  source         = "../../modules/vpc"
  app_name       = var.app_name
  vpc_cidr_block = "10.1.0.0/16"
  subnet_cidr_blocks = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.11.0/24",
    "10.1.12.0/24"
  ]
  transit_gateway_id = var.transit_gateway_id
}

module "bastion" {
  source              = "../../modules/bastion"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_c_id = module.vpc.private_subnet_c_id
  key_name            = "default"
}

