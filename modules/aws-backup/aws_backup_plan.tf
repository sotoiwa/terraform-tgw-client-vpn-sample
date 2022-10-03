resource "aws_backup_plan" "this" {
  name = "${var.app_name}-plan"

  rule {
    rule_name         = "${var.app_name}-rule"
    target_vault_name = aws_backup_vault.this.name
    schedule          = "cron(0 * * * ? *)"

    lifecycle {
      delete_after = 1
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}
