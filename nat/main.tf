#NAT
resource "aws_instance" "nat" {
  ami = "${var.aws_ami_id}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet_public1_id}"
  associate_public_ip_address = "true"
  user_data = "${file("${path.module}/nat.sh")}"
  source_dest_check = "false"
  vpc_security_group_ids = [aws_security_group.nat.id]
  tags = {
    Name = "${var.app_name}-${var.env}-nat"
  }
}

#NAT_SG
resource "aws_security_group" "nat" {
  name = "${var.app_name}-${var.env}-nat-sg"
  description = "redirect traffic"
  vpc_id = "${var.vpc_id}"
}

resource "aws_security_group_rule" "nat-ingress" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.app_cidr}.4.0/24","${var.app_cidr}.5.0/24","${var.app_cidr}.6.0/24"]
  security_group_id = aws_security_group.nat.id
}

resource "aws_security_group_rule" "nat-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat.id
}
