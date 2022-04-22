#
# Create Jump Box
#

/*
resource "aws_instance" "jumpbox" {

  ami                         = var.jumpbox_ami
  instance_type               = "m5.2xlarge"
  key_name                    = var.ec2_key_name  
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
