## Create the SSLO Security Stack Route Table
resource "aws_route_table" "sslo-route-table" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sslo_igw.id
  }
  route {
    cidr_block         = var.vpc_cidrs["application"]
    transit_gateway_id = aws_ec2_transit_gateway.sslo-tgw.id
  }
  tags = {
    Name = "${var.prefix}-sslo-route-table"
  }
}


## Create the SSLO Security Stack Route Table Associations
resource "aws_route_table_association" "sslo-route-table-management" {
  subnet_id      = aws_subnet.management.id
  route_table_id = aws_route_table.sslo-route-table.id
}

resource "aws_route_table_association" "sslo-route-table-external" {
  subnet_id      = aws_subnet.external.id
  route_table_id = aws_route_table.sslo-route-table.id
}

resource "aws_route_table_association" "sslo-route-table-DMZ1" {
  subnet_id      = aws_subnet.DMZ1.id
  route_table_id = aws_route_table.sslo-route-table.id
}

resource "aws_route_table_association" "sslo-route-table-DMZ2" {
  subnet_id      = aws_subnet.DMZ2.id
  route_table_id = aws_route_table.sslo-route-table.id
}

resource "aws_route_table_association" "sslo-route-table-DMZ3" {
  subnet_id      = aws_subnet.DMZ3.id
  route_table_id = aws_route_table.sslo-route-table.id
}

resource "aws_route_table_association" "sslo-route-table-DMZ4" {
  subnet_id      = aws_subnet.DMZ4.id
  route_table_id = aws_route_table.sslo-route-table.id
}


## Create the Internal Subnet Association with Separate Route Table
resource "aws_route_table_association" "sslo-internal-subnet-route-table" {
  subnet_id      = aws_subnet.internal.id
  route_table_id = aws_route_table.sslo-internal-subnet-route-table.id
}


## Create the Main SSLO Security Stack Route Table asscociation
resource "aws_main_route_table_association" "sslo-main-route-table-association" {
  vpc_id         = module.vpc.vpc_id
  route_table_id = aws_route_table.sslo-route-table.id
}


## Create the IGW
resource "aws_internet_gateway" "sslo_igw" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "${var.prefix}-sslo-igw"
  }
}


## Create the SSLO TGW App Stack Route Table
resource "aws_route_table" "sslo-appstack-route-table" {
  vpc_id = aws_vpc.appstack.id
  route {
    cidr_block         = var.vpc_cidrs["vpc"]
    transit_gateway_id = aws_ec2_transit_gateway.sslo-tgw.id
  }
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.sslo-tgw.id
  }
  tags = {
    Name = "${var.prefix}-sslo-appstack-route-table"
  }
}


## Create the Main SSLO TGW App Stack Route Table asscociation
resource "aws_main_route_table_association" "sslo-main-appstack-route-table-association" {
  vpc_id         = aws_vpc.appstack.id
  route_table_id = aws_route_table.sslo-appstack-route-table.id
}


## Create the SSLO TGW App Stack Route Table Associations
resource "aws_route_table_association" "sslo-appstack-route-table" {
  subnet_id      = aws_subnet.tgw-appstack.id
  route_table_id = aws_route_table.sslo-appstack-route-table.id
}


## Create the Internal BIG-IP Subnet Route Table
resource "aws_route_table" "sslo-internal-subnet-route-table" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.sslo_bigip_internal.id
  }
  route {
    cidr_block         = var.vpc_cidrs["application"]
    transit_gateway_id = aws_ec2_transit_gateway.sslo-tgw.id
  }
  tags = {
    Name = "${var.prefix}-sslo-internal-subnet-route-table"
  }
}
