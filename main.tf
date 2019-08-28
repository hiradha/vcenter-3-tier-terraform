provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vsphere_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.vsphere_resource_pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_virtual_machine_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

 resource "vsphere_virtual_machine" "cloned_virtual_machine_web" {
   name             = "${var.vsphere_virtual_machine_name_web}"
   resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
   datastore_id     = "${data.vsphere_datastore.datastore.id}"

//  num_cpus = "${data.vsphere_virtual_machine.template.num_cpus}"
//  memory   = "${data.vsphere_virtual_machine.template.memory}"
   guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

   scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

   network_interface {
     network_id   = "${data.vsphere_network.network.id}"
     adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
   }

   disk {
     label = "disk0"
     size = "${data.vsphere_virtual_machine.template.disks.0.size}"
   }

   clone {
     template_uuid = "${data.vsphere_virtual_machine.template.id}"
   }

   provisioner "remote-exec" {
     inline = ["sudo apt-get update && sudo apt-get install python -y"]

     connection {
       host = vsphere_virtual_machine.cloned_virtual_machine_web.default_ip_address
       type        = "ssh"
       user        = var.ansible_user
       password = var.ansible_ssh
     }
   }

   provisioner "local-exec" {
     command = "ansible-playbook -b -u admini -i '${vsphere_virtual_machine.cloned_virtual_machine_web.default_ip_address},' -e 'ansible_user=${var.ansible_user} ansible_ssh_pass=${var.ansible_ssh} ansible_sudo_pass=${var.ansible_sudo}' playbooks/nginx.yml"
   }

 }

 resource "vsphere_virtual_machine" "cloned_virtual_machine_app" {
   name             = "${var.vsphere_virtual_machine_name_app}"
   resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
   datastore_id     = "${data.vsphere_datastore.datastore.id}"

 //  num_cpus = "${data.vsphere_virtual_machine.template.num_cpus}"
 //  memory   = "${data.vsphere_virtual_machine.template.memory}"
   guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

   scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

   network_interface {
     network_id   = "${data.vsphere_network.network.id}"
     adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
   }

   disk {
     label = "disk0"
     size = "${data.vsphere_virtual_machine.template.disks.0.size}"
   }

   clone {
     template_uuid = "${data.vsphere_virtual_machine.template.id}"
   }

  provisioner "remote-exec" {
    inline = ["sudo apt-get update && sudo apt-get install python unzip -y"]

    connection {
      host = vsphere_virtual_machine.cloned_virtual_machine_app.default_ip_address
      type        = "ssh"
      user        = var.ansible_user
      password = var.ansible_ssh
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -b -u admini -i '${vsphere_virtual_machine.cloned_virtual_machine_app.default_ip_address},' -e 'ansible_user=${var.ansible_user} ansible_ssh_pass=${var.ansible_ssh} ansible_sudo_pass=${var.ansible_sudo}' playbooks/tomcat.yml"
  }
 }

resource "vsphere_virtual_machine" "cloned_virtual_machine_database" {
   name             = "${var.vsphere_virtual_machine_name_database}"
   resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
   datastore_id     = "${data.vsphere_datastore.datastore.id}"

 //  num_cpus = "${data.vsphere_virtual_machine.template.num_cpus}"
 //  memory   = "${data.vsphere_virtual_machine.template.memory}"
   guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

   scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

   network_interface {
     network_id   = "${data.vsphere_network.network.id}"
     adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
   }

   disk {
     label = "disk0"
     size = "${data.vsphere_virtual_machine.template.disks.0.size}"
   }

   clone {
     template_uuid = "${data.vsphere_virtual_machine.template.id}"
   }

  provisioner "remote-exec" {
    inline = ["sudo apt-get update && sudo apt-get install python unzip -y"]

    connection {
      host = vsphere_virtual_machine.cloned_virtual_machine_database.default_ip_address
      type        = "ssh"
      user        = var.ansible_user
      password = var.ansible_ssh
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -b -u admini -i '${vsphere_virtual_machine.cloned_virtual_machine_database.default_ip_address},' -e 'ansible_user=${var.ansible_user} ansible_ssh_pass=${var.ansible_ssh} ansible_sudo_pass=${var.ansible_sudo}' playbooks/postgres.yml"
  }
}
