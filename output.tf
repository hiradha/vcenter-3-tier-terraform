 output "web_ip" {
    value = "${vsphere_virtual_machine.cloned_virtual_machine_web.default_ip_address}"
 }
 output "app_ip" {
    value = "${vsphere_virtual_machine.cloned_virtual_machine_app.default_ip_address}"
 }
 output "db_ip" {
    value = "${vsphere_virtual_machine.cloned_virtual_machine_database.default_ip_address}"
 }
