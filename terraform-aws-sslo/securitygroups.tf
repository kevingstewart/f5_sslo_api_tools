## Create Security Group for Management
resource "aws_security_group" "sslo_management" {
  vpc_id      = module.vpc.vpc_id
  description = "sslo_sg_management"
  name        = "sslo_sg_management"
  tags = {
    Name = "${var.prefix}-sslo_sg_management"
  }
  ingress {
    # SSH (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.mgmt_src_addr_prefixes
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## Create Security Group for External
resource "aws_security_group" "sslo_external" {
  vpc_id      = module.vpc.vpc_id
  description = "sslo_sg_external"
  name        = "sslo_sg_external"
  tags = {
    Name = "${var.prefix}-sslo_sg_external"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## Create Security Group for Internal
resource "aws_security_group" "sslo_internal" {
  vpc_id      = module.vpc.vpc_id
  description = "sslo_sg_internal"
  name        = "sslo_sg_internal"
  tags = {
    Name = "${var.prefix}-sslo_sg_internal"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## Create Security Group for Inspection Zone
resource "aws_security_group" "sslo_inspection_zone" {
  vpc_id      = module.vpc.vpc_id
  description = "sslo_sg_inspection_zone"
  name        = "sslo_sg_inspection_zone"
  tags = {
    Name = "${var.prefix}-sslo_sg_inspection_zone"
  }
  ingress {
    # Allow All (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


## Create Security Group for TGW Webapp
resource "aws_security_group" "sslo_appstack" {
  vpc_id      = aws_vpc.appstack.id
  description = "sslo_sg_appstack"
  name        = "sslo_sg_appstack"
  tags = {
    Name = "${var.prefix}-sslo_sg_appstack"
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
