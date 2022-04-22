## Create the VPC's for both stacks
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "${var.prefix}-terraform-aws-sslo-securitystack"
  cidr                 = var.vpc_cidrs["vpc"]
  azs                  = [var.az]
  enable_nat_gateway   = "true"
  enable_dns_hostnames = "true"
}

resource "aws_vpc" "appstack" {
  cidr_block           = var.vpc_cidrs["application"]
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.prefix}-terraform-aws-sslo-appstack"
  }
}
