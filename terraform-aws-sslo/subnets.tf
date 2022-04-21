## Create Management Subnet 
resource "aws_subnet" "management" {
  vpc_id                   = module.vpc.vpc_id
  cidr_block               = "10.0.1.0/24"
  availability_zone        = var.az
  tags = {
    Name = "${var.prefix}-sslo-management"
    Group_Name = "${var.prefix}-sslo-management"
  }
}


## Create External Subnet
resource "aws_subnet" "external" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.2.0/24"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-sslo-external"
    Group_Name = "${var.prefix}-sslo-external"
  }
}


## Create DMZ1 Subnet
resource "aws_subnet" "DMZ1" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.3.0/25"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-DMZ1"
    Group_Name = "${var.prefix}-DMZ1"
  }
}


## Create DMZ2 Subnet
resource "aws_subnet" "DMZ2" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.3.128/25"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-DMZ2"
    Group_Name = "${var.prefix}-DMZ2"
  }
}


## Create DMZ3 Subnet
resource "aws_subnet" "DMZ3" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.4.0/25"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-DMZ3"
    Group_Name = "${var.prefix}-DMZ3"
  }
}


## Create DMZ4 Subnet
resource "aws_subnet" "DMZ4" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.4.128/25"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-DMZ4"
    Group_Name = "${var.prefix}-DMZ4"
  }
}


## Create Internal Subnet
resource "aws_subnet" "internal" {
  vpc_id                = module.vpc.vpc_id
  cidr_block            = "10.0.5.0/24"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-internal"
    Group_Name = "${var.prefix}-internal"
  }
}


## Create TGW App Subnet
resource "aws_subnet" "tgw-appstack" {
  vpc_id                = aws_vpc.appstack.id
  cidr_block            = "192.168.1.0/24"
  availability_zone     = var.az
  tags = {
    Name = "${var.prefix}-tgw-appstack"
    Group_Name = "${var.prefix}-tgw-appstack"
  }
}