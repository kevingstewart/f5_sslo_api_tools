#
# Create Inspection Devices
#

# Inspection Device 1 
resource "aws_instance" "inspection_device_1" {
  ami               = var.inspection_ami
  instance_type     = "t2.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az
  depends_on        = [aws_internet_gateway.sslo_igw]
  user_data         = <<-EOF
                      #!/bin/bash
                      sudo ip route add 10.0.2.0/24 via 10.0.3.245 dev eth2
                      sudo sysctl -w net.ipv4.ip_forward=1
                      EOF

  tags = {
    Name = "${var.prefix}-sslo-inspection-device-1"
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_management_1.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_dmz1_1.id
    device_index         = 1
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_inspection_device_dmz2_1.id
    device_index         = 2
  }
}


# Inspection Device 2 
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
