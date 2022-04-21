
## Create Jump Box
#resource "aws_instance" "jumpbox" {
#
#  ami                         = var.jumpbox_ami
#  instance_type               = "m5.2xlarge"
#  key_name                    = var.ec2_key_name  
#  availability_zone           = var.az
#  depends_on                  = [aws_internet_gateway.sslo_igw]
#  tags = {
#    Name = "${var.prefix}-sslo-jumpbox"
#  }
#  network_interface {
#    network_interface_id      = aws_network_interface.sslo_jumpbox_management.id
#    device_index              = 0
#  }
#}



## Create BIG-IP(SSLO)
resource "aws_instance" "sslo" {
  ami                         = var.sslo_ami  
  instance_type               = "m5.4xlarge"
  key_name                    = var.ec2_key_name  
  availability_zone           = var.az
  depends_on                  = [aws_internet_gateway.sslo_igw]
  user_data                   = "${file("${path.module}/f5_onboard.tmpl")}"
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


## Create Test WebApp Server
resource "aws_instance" "webapp-server" {
  ami                         = var.webapp_ami
  instance_type               = "t3.small"
  key_name                    = var.ec2_key_name  
  availability_zone           = var.az
  depends_on                  = [aws_internet_gateway.sslo_igw]
  tags = {
    Name = "${var.prefix}-sslo-webapp-server"
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_test_webapp.id
    device_index              = 0
  }
}


## Create Inspection Device 1 
resource "aws_instance" "inspection_device_1" {
  ami                         = var.inspection_ami
  instance_type               = "t2.small"
  key_name                    = var.ec2_key_name  
  availability_zone           = var.az
  depends_on                  = [aws_internet_gateway.sslo_igw]
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo ip route add 10.0.2.0/24 via 10.0.3.245 dev eth2
                                sudo sysctl -w net.ipv4.ip_forward=1
                                EOF
                              
   tags = {
    Name = "${var.prefix}-sslo-inspection-device-1"
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_management_1.id
    device_index              = 0
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_dmz1_1.id
    device_index              = 1
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_dmz2_1.id
    device_index              = 2
  }
}


## Create Inspection Device 2 
resource "aws_instance" "inspection_device_2" {
  ami                         = var.inspection_ami
  instance_type               = "t2.small"
  key_name                    = var.ec2_key_name  
  availability_zone           = var.az
  depends_on                  = [aws_internet_gateway.sslo_igw]
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo ip route add 10.0.2.0/24 via 10.0.4.245 dev eth2
                                sudo sysctl -w net.ipv4.ip_forward=1
                                EOF
                              
   tags = {
    Name = "${var.prefix}-sslo-inspection-device-2"
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_management_2.id
    device_index              = 0
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_dmz3.id
    device_index              = 1
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_inspection_device_dmz4.id
    device_index              = 2
  }
}