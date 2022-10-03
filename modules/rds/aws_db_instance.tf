resource "aws_db_instance" "postgres" {
  identifier             = "${var.app_name}-postgres-db"
  allocated_storage      = 10
  max_allocated_storage  = 100
  engine                 = "postgres"
  engine_version         = "14.2"
  instance_class         = "db.m6i.large"
  storage_type           = "gp2"
  username               = var.db_master_username
  password               = var.db_master_password
  port                   = 5432
  vpc_security_group_ids = [aws_security_group.this.id]
  db_subnet_group_name   = aws_db_subnet_group.this.id
  parameter_group_name   = aws_db_parameter_group.postgres.name
  storage_encrypted      = true
  copy_tags_to_snapshot  = true

  deletion_protection = false
  skip_final_snapshot = true
  apply_immediately   = true

  monitoring_role_arn          = aws_iam_role.this.arn
  monitoring_interval          = 60
  performance_insights_enabled = true

  multi_az = false

  lifecycle {
    ignore_changes = [password]
  }

  tags = {
    Backup = "true"
  }
}

resource "aws_db_parameter_group" "postgres" {
  name   = "${var.app_name}-postgres-pg"
  family = "postgres14"
}
