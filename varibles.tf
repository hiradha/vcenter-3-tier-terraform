# vsphere login account. defaults to admin account
variable "vsphere_user" {
  default = "administrator@vsphere.local"
}

# vsphere account password. empty by default.
variable "vsphere_password" {}

# vsphere server, defaults to localhost
variable "vsphere_server" {
  default = "localhost"
}

# vsphere datacenter the virtual machine will be deployed to. empty by default.
variable "vsphere_datacenter" {}

# vsphere resource pool the virtual machine will be deployed to. empty by default.
variable "vsphere_resource_pool" {}

# vsphere datastore the virtual machine will be deployed to. empty by default.
variable "vsphere_datastore" {}

# vsphere network the virtual machine will be connected to. empty by default.
variable "vsphere_network" {}

# vsphere virtual machine template that the virtual machine will be cloned from. empty by default.
variable "vsphere_virtual_machine_template" {}

# the name of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_name_web" {}

# the name of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_name_app" {}

# the name of the vsphere virtual machine that is created. empty by default.
variable "vsphere_virtual_machine_name_database" {}

# your ssh user that can sudo up to root
variable "ansible_user" {}

# your ssh password for the ansible user above
variable "ansible_ssh" {}

# your sudo password for the ansible user above
variable "ansible_sudo" {}
