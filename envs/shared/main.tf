data "aws_acm_certificate" "server" {
  domain   = "server"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "client1" {
  domain   = "client1.domain.tld"
  statuses = ["ISSUED"]
}

module "vpc" {
  source                          = "../../modules/vpc-shared"
  app_name                        = var.app_name
  server_certificate              = data.aws_acm_certificate.server
  root_certificate                = data.aws_acm_certificate.client1
  vpc_migration_id                = var.vpc_migration_id
  vpc_migration_cidr              = var.vpc_migration_cidr
  vpc_migration_tgw_attachment_id = var.vpc_migration_tgw_attachment_id
  vpc_dev_id                      = var.vpc_dev_id
  vpc_dev_cidr                    = var.vpc_dev_cidr
  vpc_dev_tgw_attachment_id       = var.vpc_dev_tgw_attachment_id
}

module "bastion" {
  source              = "../../modules/bastion"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_c_id = module.vpc.private_subnet_c_id
  key_name            = "default"
}
