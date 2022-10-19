# DHCP Server Role
This role will setup a basic ISC-DHCP server on an Ubuntu Linux machine. 

Little additional configuration is applied. This should not be used for production purposes. Only use this role in POC or lab environments.

## Dependencies
* Internet access (for `apt`)
* `dhcp_network` variable in `vars/main.yml`

## Defaults
* Local user `ubuntu` with password `ubuntu`
* DHCP pool network of `10.10.150.0/24`