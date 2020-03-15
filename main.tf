#S3
terraform{
  backend "s3"{

  }
}

#DATA AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

#PROVIDER
provider "aws" {
  region  = "${var.app_region}"
}

#VPC
resource "aws_vpc" "main" {
  cidr_block = "${var.app_cidr}.0.0/16"
  tags = {
    Name = "${var.app_name}-${var.env}-vpc"
  }
}

#IGW
resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "${var.app_name}-${var.env}-igw"
  }
}

#MODULE SUBNETS
module "subnets" {
  source = "./subnets"

  vpc_id             = "${aws_vpc.main.id}"
  app_cidr           = "${var.app_cidr}"
  app_region         = "${var.app_region}"
  app_name           = "${var.app_name}"
  env                = "${var.env}"
}

#MODULE INSTANCE NAT
module "nat" {
  source = "./nat"

  aws_ami_id            = "${data.aws_ami.ubuntu.id}"
  subnet_public1_id     = "${module.subnets.public1_id}"
  app_name              = "${var.app_name}"
  env                   = "${var.env}"
  vpc_id                = "${aws_vpc.main.id}"
  app_cidr              = "${var.app_cidr}"
}
  
#MODULE ROUTE TABLES
module "route_tables" {
  source = "./route_tables"

  subnet_public1_id     = "${module.subnets.public1_id}"
  subnet_public2_id     = "${module.subnets.public2_id}"
  subnet_public3_id     = "${module.subnets.public3_id}"
  subnet_private1_id    = "${module.subnets.private1_id}"
  subnet_private2_id    = "${module.subnets.private2_id}"
  subnet_private3_id    = "${module.subnets.private3_id}"
  nat_id                = "${module.nat.nat_id}"
  default_rtb_id        = "${aws_vpc.main.default_route_table_id}"
  igw_id                = "${aws_internet_gateway.main.id}"
  app_name              = "${var.app_name}"
  env                   = "${var.env}"
  vpc_id                = "${aws_vpc.main.id}"
}
