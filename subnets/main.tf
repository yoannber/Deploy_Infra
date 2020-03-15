#SUBNETS
resource "aws_subnet" "public1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.1.0/24"
  availability_zone = "${var.app_region}a"
  tags = {
    Name = "${var.app_name}-${var.env}-public-1-subnet"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.2.0/24"
  availability_zone = "${var.app_region}b"
  tags = {
    Name = "${var.app_name}-${var.env}-public-2-subnet"
  }
}

resource "aws_subnet" "public3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.3.0/24"
  availability_zone = "${var.app_region}c"
  tags = {
    Name = "${var.app_name}-${var.env}-public-3-subnet"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.4.0/24"
  availability_zone = "${var.app_region}a"
  tags = {
    Name = "${var.app_name}-${var.env}-private-1-subnet"
  }
}

resource "aws_subnet" "private2" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.5.0/24"
  availability_zone = "${var.app_region}b"
  tags = {
    Name = "${var.app_name}-${var.env}-private-2-subnet"
  }
}

resource "aws_subnet" "private3" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.app_cidr}.6.0/24"
  availability_zone = "${var.app_region}c"
  tags = {
    Name = "${var.app_name}-${var.env}-private-3-subnet"
  }
}
