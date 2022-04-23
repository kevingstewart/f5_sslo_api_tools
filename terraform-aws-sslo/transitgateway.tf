## Create the TGW
resource "aws_ec2_transit_gateway" "sslo-tgw" {
  description = "The TGW for the SSLO Config"
  tags = {
    Name = "${var.prefix}-sslo-tgw"
  }
}


## Create the TGW Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "sslo_security_stack" {
  subnet_ids             = [aws_subnet.internal.id]
  transit_gateway_id     = aws_ec2_transit_gateway.sslo-tgw.id
  vpc_id                 = module.vpc.vpc_id
  appliance_mode_support = "enable"
  tags = {
    Name = "${var.prefix}-sslo-security-stack-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "sslo_security_appstack" {
  subnet_ids             = [aws_subnet.tgw-appstack.id]
  transit_gateway_id     = aws_ec2_transit_gateway.sslo-tgw.id
  vpc_id                 = aws_vpc.appstack.id
  appliance_mode_support = "enable"
  tags = {
    Name = "${var.prefix}-sslo-app-stack-tgw-attachment"
  }
}


## Set static route pointing to the SSLO VPC 
resource "aws_ec2_transit_gateway_route" "return_public_ip" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.sslo_security_stack.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.sslo-tgw.association_default_route_table_id
}


## Create the TGW Route Table
resource "aws_ec2_transit_gateway_route_table" "sslo-tgw-rt" {
  transit_gateway_id = aws_ec2_transit_gateway.sslo-tgw.id
  tags = {
    Name = "${var.prefix}-sslo-tgw-route-table"
  }
}