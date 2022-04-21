## Create the VPC's for both stacks
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name                 = "${var.prefix}-terraform-aws-sslo-securitystack"
  cidr                 = "10.0.0.0/16"
  azs                  = [var.az]
  enable_nat_gateway   = "true"
  enable_dns_hostnames = "true"
}

resource "aws_vpc" "appstack" {
  cidr_block           = "192.168.1.0/24"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.prefix}-terraform-aws-sslo-appstack"
  }
}