resource "aws_route53_zone" "this" {
  for_each = toset(local.services)

  name = "${each.key}.ap-northeast-1.amazonaws.com"

  vpc {
    vpc_id = aws_vpc.this.id
  }

  vpc {
    vpc_id = var.vpc_migration_id
  }

  vpc {
    vpc_id = var.vpc_dev_id
  }
}

resource "aws_route53_record" "this" {
  for_each = toset(local.services)

  zone_id = lookup(aws_route53_zone.this, "${each.key}").zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = lookup(aws_vpc_endpoint.interface, "${each.key}").dns_entry[0].dns_name
    zone_id                = lookup(aws_vpc_endpoint.interface, "${each.key}").dns_entry[0].hosted_zone_id
    evaluate_target_health = false
  }
}
