variable "app_name" {}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr_blocks" {
  type = list(any)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}
variable "transit_gateway_id" {}

data "aws_region" "this" {}
data "aws_caller_identity" "this" {}
