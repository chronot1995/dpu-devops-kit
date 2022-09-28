# Reboot_os_redux

This is a redesign of the reboot role that will utilize the inventory file to determine if a BMC is present for ipmitools.

Supports the use of an extra variable `reboot_os=false` to not reboot the host OS.

## Dependencies

- None

## Defaults

- `reboot_timeout` is set to `3600` in `vars/main.yml`
- `reboot_os` is set to `true` in `tasks/main.yml`
