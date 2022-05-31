# Reboot
This role reboots a host and waits a defined time for the host to come back online.  

Supports the use of an extra variable `reboot_os=false` to not reboot the host OS.

## Dependencies
* None

## Defaults
* `reboot_timeout` is set to `3600` in `vars/main.yml`
* `reboot_os` is set to `true` in `tasks/main.yml`
