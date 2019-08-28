# vCenter 3 tier terraform example

## Scope

This is an example of a three tier application stack
using `terraform` and `ansible`. This has been tested on
Debian 10, and only Debian 10.

- nginx frontend
- tomcat application layer
- postgres database

## Usage

First, fill out the [terraform.tfvars](terraform.tfvars) file with your settings:

```bash
vsphere_user = "administrator@vsphere.local"
vsphere_password = "PASSWORD_HERE"
vsphere_server = "IP_ADDY_HERE"
vsphere_datacenter = "datacenter"
vsphere_datastore = "vsanDatastore" # or wherever
vsphere_resource_pool = "cluster1/" # if you have a cluster
vsphere_network = "NETWORK"
vsphere_virtual_machine_template = "AWESOME_TEMPLATE"
vsphere_virtual_machine_name_web = "NAME_WEB_SERVER"
vsphere_virtual_machine_name_app = "NAME_APP_SERVER"
vsphere_virtual_machine_name_database = "NAME_DATABASE_SERVER
ansible_user = "YOUR_ANSIBLE_USER"
ansible_ssh = "YOUR_ANSIBLE_SSH_PASSWORD"
ansible_sudo = "YOUR_SUDO_PASSWORD"

```
Next, run the following command to pull down the `vcenter` provider:

```bash
terraform init
```

If everything is good you can run:

```bash
terraform apply
```

And the three tier app, `nginx`, `tomcat` and `postgres` will be created. You will get an output of the three machines with the IPs of each.

If you want to destroy everything go a head and run:

```bash
terraform destroy
```

## License & Authors

If you would like to see the detailed LICENCE click [here](./LICENCE).

- Author: JJ Asghar <awesome@ibm.com>
- Author: David Roberts <david.ru.roberts@gmail.com>

```text
Copyright:: 2019- IBM, Inc
Copyright:: 2019- David Roberts

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
