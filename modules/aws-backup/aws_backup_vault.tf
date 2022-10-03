data "aws_kms_key" "this" {
  key_id = "alias/aws/backup"
}

resource "aws_backup_vault" "this" {
  name        = "${var.app_name}-vault"
  kms_key_arn = data.aws_kms_key.this.arn
}
