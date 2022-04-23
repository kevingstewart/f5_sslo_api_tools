output "sslo_internal" {
  value       = aws_network_interface.sslo_bigip_internal.private_ip
  description = "The private IP address of SSLO internal interface."
}

output "sslo_external" {
  value       = aws_network_interface.sslo_bigip_external.private_ip
  description = "The private IP address of SSLO external interface."
}

output "sslo_dmz1" {
  value       = aws_network_interface.sslo_bigip_dmz1.private_ip
  description = "The private IP address of SSLO DMZ1 interface."
}

output "sslo_dmz2" {
  value       = aws_network_interface.sslo_bigip_dmz2.private_ip
  description = "The private IP address of SSLO DMZ2 interface."
}

output "sslo_dmz3" {
  value       = aws_network_interface.sslo_bigip_dmz3.private_ip
  description = "The private IP address of SSLO DMZ3 interface."
}

output "sslo_dmz4" {
  value       = aws_network_interface.sslo_bigip_dmz4.private_ip
  description = "The private IP address of SSLO DMZ4 interface."
}

output "sslo_management" {
  value       = aws_network_interface.sslo_bigip_management.private_ip
  description = "The private IP address of SSLO management interface."
}

output "sslo_management_public_ip" {
  value       = aws_instance.sslo.public_ip
  description = "The public IP address of SSLO management interface."
}

output "sslo_management_public_dns" {
  value       = aws_instance.sslo.public_dns
  description = "The public DNS of SSLO."
}

#output "jumpbox_public_ip" {
#  value       = aws_instance.jumpbox.public_ip
#  description = "The public IP of the jumpbox."
#}

#output "jumpbox_public_dns" {
#  value       = aws_instance.jumpbox.public_dns
#  description = "The public DNS of the jumpbox."
#}

output "sslo_vip" {
  value       = aws_eip.sslo_vip.public_ip
  description = "The public IP of the VIP"
}

output "webapp_internal" {
  value       = aws_instance.webapp-server.private_ip
  description = "Private IP of the web app server"
}

output "inspection_service_ip_1" {
  value       = aws_network_interface.sslo_inspection_device_dmz1_1.private_ip
  description = "Private IP of the Inspection Service One IP"
}

output "inspection_service_ip_2" {
  value       = aws_network_interface.sslo_inspection_device_dmz3.private_ip
  description = "Private IP of the Inspection Service Two IP"
}

output "sslo_external_private_vip" {
  value       = aws_network_interface.sslo_bigip_external.private_ips
  description = "The private IP address of SSLO external VIP interface."
}

