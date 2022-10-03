variable "app_name" {}
variable "server_certificate" {}
variable "root_certificate" {}
variable "vpc_migration_id" {}
variable "vpc_migration_cidr" {}
variable "vpc_migration_tgw_attachment_id" {}
variable "vpc_dev_id" {}
variable "vpc_dev_cidr" {}
variable "vpc_dev_tgw_attachment_id" {}

data "aws_region" "this" {}
data "aws_caller_identity" "this" {}
