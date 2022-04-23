#
# Create Test WebApp Server
#
resource "aws_instance" "webapp-server" {
  ami               = var.webapp_ami
  instance_type     = "t3.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az
  depends_on        = [aws_internet_gateway.sslo_igw]
  tags = {
    Name = "${var.prefix}-sslo-webapp-server"
  }
  network_interface {
    network_interface_id = aws_network_interface.sslo_test_webapp.id
    device_index         = 0
  }
}
