resource "local_file" "ansible_vars" {
  content = <<-DOC
     ansible_host: ${aws_instance.sslo.public_ip}
     snort1_host: ${aws_network_interface.sslo_inspection_device_dmz1_1.private_ip}
     snort2_host: ${aws_network_interface.sslo_inspection_device_dmz3.private_ip}
     webapp_pool: ${aws_instance.webapp-server.private_ip}
     DOC
  filename = "./ansible_vars.yml"
}
