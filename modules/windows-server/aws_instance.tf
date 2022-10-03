data "aws_ssm_parameter" "this" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2019-Japanese-Full-Base"
}

resource "aws_instance" "this" {
  ami                         = data.aws_ssm_parameter.this.value
  instance_type               = "t3.small"
  subnet_id                   = var.private_subnet_a_id
  vpc_security_group_ids      = [aws_security_group.this.id]
  key_name                    = var.key_name
  associate_public_ip_address = false
  iam_instance_profile        = aws_iam_instance_profile.this.id
  monitoring                  = true

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name          = "${var.app_name}-windows-server"
    "Patch Group" = "DEV"
  }
}
