## Create Ephemeral EIP
resource "aws_eip" "jumpbox" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags = {
    Name = "${var.prefix}-eip-jumpbox"
  }
}

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


## Create EIP Association with Jump Box Management Interface
resource "aws_eip_association" "jumpbox_eip" {
  network_interface_id = aws_network_interface.sslo_jumpbox_management.id
  allocation_id        = aws_eip.jumpbox.id
}


## Create EIP Association with SSLO Management Interface
resource "aws_eip_association" "sslo_management" {
  network_interface_id = aws_network_interface.sslo_bigip_management.id
  allocation_id        = aws_eip.sslo_management.id
}

