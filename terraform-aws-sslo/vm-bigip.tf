
#
# Generate cloud-init script for BIG-IP
#
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

#
# Create BIG-IP(SSLO)
#
resource "aws_instance" "sslo" {
  ami               = var.sslo_ami
  instance_type     = var.instance_type
  key_name          = var.ec2_key_name
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
