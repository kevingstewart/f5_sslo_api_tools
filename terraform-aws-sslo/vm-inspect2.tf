#
# Create Inspection Device 2
#

## Create Management Network Interface for Inspection Device 2
resource "aws_network_interface" "sslo_inspection_device_management_2" {
  subnet_id         = aws_subnet.management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_management_2"
  }
}

## Create DMZ3 Network Interface for Inspection Device 2
resource "aws_network_interface" "sslo_inspection_device_dmz3" {
  subnet_id         = aws_subnet.DMZ3.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz3"
  }
}

## Create DMZ4 Network Interface for Inspection Device 2
resource "aws_network_interface" "sslo_inspection_device_dmz4" {
  subnet_id         = aws_subnet.DMZ4.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_inspection_zone.id]
  tags = {
    Name = "${var.prefix}-sslo_inspection_device_dmz4"
  }
}


## Inspection Device 2 
resource "aws_instance" "inspection_device_2" {
  ami               = var.inspection_ami
  instance_type     = "t2.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az
  depends_on        = [aws_internet_gateway.sslo_igw]
  user_data         = <<-EOF
                      #!/bin/bash
                      sudo ip route add 10.0.2.0/24 via 10.0.4.245 dev eth2
                      sudo sysctl -w net.ipv4.ip_forward=1
                      EOF

  tags = {
    Name = "${var.prefix}-sslo-inspection-device-2"
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_management_2.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_dmz3.id
    device_index         = 1
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_dmz4.id
    device_index         = 2
  }
}
