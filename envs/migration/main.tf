module "vpc" {
  source         = "../../modules/vpc"
  app_name       = var.app_name
  vpc_cidr_block = "10.0.0.0/16"
  subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24"
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

module "windows_server" {
  source              = "../../modules/windows-server"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_c_id = module.vpc.private_subnet_c_id
  key_name            = "default"
}

module "aws_backup" {
  source   = "../../modules/aws-backup"
  app_name = var.app_name
}

module "rds" {
  source                           = "../../modules/rds"
  app_name                         = var.app_name
  vpc_id                           = module.vpc.vpc_id
  isolated_subnet_a_id             = module.vpc.isolated_subnet_a_id
  isolated_subnet_c_id             = module.vpc.isolated_subnet_c_id
  security_group_windows_server_id = module.windows_server.security_group_windows_server_id
  db_master_username               = var.db_master_username
  db_master_password               = var.db_master_password
}
