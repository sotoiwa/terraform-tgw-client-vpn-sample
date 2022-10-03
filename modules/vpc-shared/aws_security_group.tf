resource "aws_security_group" "client_vpn_endpoint" {
  name   = "${var.app_name}-client-vpn-endpoint-sg"
  vpc_id = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc_endpoints" {
  name   = "${var.app_name}-vpc-endpoint-sg"
  vpc_id = aws_vpc.this.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      aws_vpc.this.cidr_block,
      "10.0.0.0/16",
      "10.1.0.0/16"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
