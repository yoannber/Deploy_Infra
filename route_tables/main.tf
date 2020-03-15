#MAIN_RTB
resource "aws_default_route_table" "main" {
  default_route_table_id = "${var.default_rtb_id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${var.nat_id}"
  }
  tags = {
    Name = "${var.app_name}-${var.env}-main-rtb"
  }
}

#CUSTOM_RTB
resource "aws_route_table" "custom" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igw_id}"
  }
  tags = {
    Name = "${var.app_name}-${var.env}-custom-rtb"
  }
}

#RTB_ASSOCIATION
resource "aws_route_table_association" "pub1" {
  subnet_id = "${var.subnet_public1_id}"
  route_table_id = "${aws_route_table.custom.id}"
}

resource "aws_route_table_association" "pub2" {
  subnet_id = "${var.subnet_public2_id}"
  route_table_id = "${aws_route_table.custom.id}"
}

resource "aws_route_table_association" "pub3" {
  subnet_id = "${var.subnet_public3_id}"
  route_table_id = "${aws_route_table.custom.id}"
}

resource "aws_route_table_association" "priv1" {
  subnet_id = "${var.subnet_private1_id}"
  route_table_id = "${aws_default_route_table.main.id}"
}

resource "aws_route_table_association" "priv2" {
  subnet_id = "${var.subnet_private2_id}"
  route_table_id = "${aws_default_route_table.main.id}"
}

resource "aws_route_table_association" "priv3" {
  subnet_id = "${var.subnet_private3_id}"
  route_table_id = "${aws_default_route_table.main.id}"
}
