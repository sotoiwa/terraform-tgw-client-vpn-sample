resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.100.1.0/24"
  availability_zone       = "${data.aws_region.this.name}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.app_name}-private-subnet-a"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.100.2.0/24"
  availability_zone       = "${data.aws_region.this.name}c"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.app_name}-private-subnet-c"
  }
}
