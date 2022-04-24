#
# Create Jump Box
#

/*
## Create Public IP
resource "aws_eip" "jumpbox" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "${var.prefix}-eip-jumpbox"
  }
}

## Create Management Network Interface for Jumpbox
resource "aws_network_interface" "sslo_jumpbox_management" {
  subnet_id         = aws_subnet.management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.sslo_management.id]
  tags = {
    Name = "${var.prefix}-sslo_management_jumpbox_interface"
  }
}

## Create EIP Association with Jump Box Management Interface
resource "aws_eip_association" "jumpbox_eip" {
  network_interface_id = aws_network_interface.sslo_jumpbox_management.id
  allocation_id        = aws_eip.jumpbox.id
}

## Create jump host
resource "aws_instance" "jumpbox" {

  ami                         = var.jumpbox_ami
  instance_type               = "m5.2xlarge"
  key_name                    = aws_key_pair.my_keypair.key_name  
  availability_zone           = var.az
  depends_on                  = [aws_internet_gateway.sslo_igw]
  tags = {
    Name = "${var.prefix}-sslo-jumpbox"
  }
  network_interface {
    network_interface_id      = aws_network_interface.sslo_jumpbox_management.id
    device_index              = 0
  }
}
*/
