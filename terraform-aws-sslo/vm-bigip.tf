#
# Deploy BIG-IP VM
#

## Create Public IPs
resource "aws_eip" "sslo_management" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "${var.prefix}-eip-sslo-management"
  }
}

resource "aws_eip" "sslo_vip" {
  vpc                       = true
  public_ipv4_pool          = "amazon"
  network_interface         = aws_network_interface.sslo_bigip_external.id
  associate_with_private_ip = "10.0.2.200"
  tags = {
    Name = "${var.prefix}-eip-sslo-vip"
  }
}


## Create network interfaces

## Create Management Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_management" {
  subnet_id         = aws_subnet.management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_management_bigip_interface"
  }
}

## Create EIP Association with SSLO Management Interface
resource "aws_eip_association" "sslo_management" {
  network_interface_id = aws_network_interface.sslo_bigip_management.id
  allocation_id        = aws_eip.sslo_management.id
}

## Create External Network Interface for BIG_IP(SSLO) 
resource "aws_network_interface" "sslo_bigip_external" {
  private_ips       = ["10.0.2.180", "10.0.2.200"]
  subnet_id         = aws_subnet.external.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_external.id]
  tags = {
    Name = "${var.prefix}-sslo_external_bigip_interface"
  }
}

## Create Internal Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_internal" {
  private_ips       = ["10.0.5.9"]
  subnet_id         = aws_subnet.internal.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_internal.id]
  tags = {
    Name = "${var.prefix}-sslo_internal_bigip_interface"
  }
}

## Create DMZ1 Network Interface for BIG_IP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz1" {
  private_ips       = ["10.0.3.7"]
  subnet_id         = aws_subnet.DMZ1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz1_bigip_interface"
  }
}

## Create DMZ2 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz2" {
  private_ips       = ["10.0.3.245"]
  subnet_id         = aws_subnet.DMZ2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz2_bigip_interface"
  }
}

## Create DMZ3 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz3" {
  private_ips       = ["10.0.4.7"]
  subnet_id         = aws_subnet.DMZ3.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz3_bigip_interface"
  }
}

## Create DMZ4 Network Interface for BIGIP(SSLO)
resource "aws_network_interface" "sslo_bigip_dmz4" {
  private_ips       = ["10.0.4.245"]
  subnet_id         = aws_subnet.DMZ4.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_dmz4_bigip_interface"
  }
}

## Create BIG-IP

## Generate cloud-init script for BIG-IP
data "template_file" "f5_onboard" {
  template = file("${path.module}/f5_onboard.tmpl")
  vars = {
    license_key     = var.license_key
    admin_password  = var.admin_password
    internal_selfip = "${cidrhost(var.vpc_cidrs["internal"], 9)}/24"
    external_selfip = "${cidrhost(var.vpc_cidrs["external"], 180)}/24"
    tgw_route_gw    = "${cidrhost(var.vpc_cidrs["internal"], 1)}"
    tgw_route_dest  = var.vpc_cidrs["application"]
  }
}

## Create BIG-IP(SSLO)
resource "aws_instance" "sslo" {
  ami               = var.sslo_ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az
  depends_on        = [aws_internet_gateway.sslo_igw]
  user_data         = data.template_file.f5_onboard.rendered
  tags = {
    Name = "${var.prefix}-sslo-bigip"
  }
  # set the mgmt interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_management.id
    device_index         = 0
  }
  # set the external interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_external.id
    device_index         = 1
  }
  # set the internal interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_internal.id
    device_index         = 2
  }
  # set the inspection zone (DMZ1) interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_dmz1.id
    device_index         = 3
  }
  # set the inspection zone (DMZ2) interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_dmz2.id
    device_index         = 4
  }
  # set the inspection zone (DMZ3) interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_dmz3.id
    device_index         = 5
  }
  # set the inspection zone (DMZ4) interface 
  network_interface {
    network_interface_id = aws_network_interface.sslo_bigip_dmz4.id
    device_index         = 6
  }
}
