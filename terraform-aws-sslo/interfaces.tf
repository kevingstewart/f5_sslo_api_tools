## Create Management Network Interface for Jumpbox
resource "aws_network_interface" "sslo_jumpbox_management" {
  subnet_id             = aws_subnet.management.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_management_jumpbox_interface"
  }
}


## Create Management Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_management" {
  subnet_id             = aws_subnet.management.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_management_bigip_interface"
  }
}


## Create External Network Interface for BIG_IP(SSLO) 
resource "aws_network_interface" "sslo_bigip_external" {
  private_ips            = ["10.0.2.180", "10.0.2.200"]
  subnet_id             = aws_subnet.external.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_external.id]
  tags = {
    Name = "${var.prefix}-sslo_external_bigip_interface"
  }
}


## Create Internal Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_internal" {
  private_ips            = ["10.0.5.9"]
  subnet_id             = aws_subnet.internal.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_internal.id]
  tags = {
    Name = "${var.prefix}-sslo_internal_bigip_interface"
  }
}


## Create DMZ1 Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz1" {
  private_ips            = ["10.0.3.7"]
  subnet_id             = aws_subnet.DMZ1.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz1_bigip_interface"
  }
}


## Create DMZ2 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz2" {
  private_ips            = ["10.0.3.245"]
  subnet_id             = aws_subnet.DMZ2.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz2_bigip_interface"
  }
}


## Create DMZ3 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz3" {
  private_ips            = ["10.0.4.7"]
  subnet_id             = aws_subnet.DMZ3.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz3_bigip_interface"
  }
}


## Create DMZ4 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz4" {
  private_ips            = ["10.0.4.245"]
  subnet_id             = aws_subnet.DMZ4.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz4_bigip_interface"
  }
}


## Create the Network Interface for the WebServer
resource "aws_network_interface" "sslo_test_webapp" {
  subnet_id             = aws_subnet.tgw-appstack.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_appstack.id]
  tags = {
    Name = "${var.prefix}-sslo_test_webapp"
  }
}


## Create Management Network Interface for Inspection Device One
resource "aws_network_interface" "sslo_inspection_device_management_1" {
  subnet_id             = aws_subnet.management.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_management_1"
  }
}


## Create DMZ1 Network Interface for Inspection Device One
resource "aws_network_interface" "sslo_inspection_device_dmz1_1" {
  subnet_id             = aws_subnet.DMZ1.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz1_1"
  }
}


## Create DMZ2 Network Interface for Inspection Device One
resource "aws_network_interface" "sslo_inspection_device_dmz2_1" {
  subnet_id             = aws_subnet.DMZ2.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz2_1"
  }
}


## Create Management Network Interface for Inspection Device Two
resource "aws_network_interface" "sslo_inspection_device_management_2" {
  subnet_id             = aws_subnet.management.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_management_2"
  }
}


## Create DMZ3 Network Interface for Inspection Device Two
resource "aws_network_interface" "sslo_inspection_device_dmz3" {
  subnet_id             = aws_subnet.DMZ3.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz3"
  }
}


## Create DMZ4 Network Interface for Inspection Device Two
resource "aws_network_interface" "sslo_inspection_device_dmz4" {
  subnet_id             = aws_subnet.DMZ4.id
  source_dest_check     = "false"
  security_groups       = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz4"
  }
}

