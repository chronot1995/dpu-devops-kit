# reboot_os

This is a redesign of the reboot role that will utilize the inventory file to determine if a BMC is present to cold boot the DPU, if possible.

Supports the use of an extra variable `reboot_os=false` to not reboot the host OS.

## Dependencies

- ipmitools must be installed on the host in order for this work correctly. This will be installed as part of the automation container in the project readme

- There are 3 different plays that are built into this role:
  1. x86 with a BMC / iDRAC
  2. DPU with a BMC
  3. DPU without a BMC

0. For iDRAC connectivity to work, you will need to enable "IPMI over LAN" within the iDRAC console. This setting is found:
   iDRAC Settings > Network > Connectivity > Enable IPMI over LAN > "Enabled"

1. x86 with a BMC / iDRAC

There are two things that are required in order for this cold boot from the x86 to work. First, the name of the inventory item must be in the following format:

`<dpu name>_host_bmc`

For instance:

If the DPU is named: `dpu_100gb`
The name for the DPU with an x86 with a BMC must be: `dpu_100gb_host_bmc` in the Ansible inventory file

Second, the name of the group for the x86 hosts with DPUs must be: `x86_host_bmcs`

2. DPU with a BMC

Again, there are two things that are required in order for this cold boot from the DPU to work. First, the name of the inventory item must be in the following format:

`<dpu name>_bmc`

For instance:

If the DPU is named: `dpu_100gb`
The name for the DPU with an x86 with a BMC must be: `dpu_100gb_bmc` in the Ansible inventory file

Second, the name of the group for the x86 hosts with DPUs must be: `dpu_bmcs`

3. DPU without a BMC

This will be the final waterfall step and will fail to this play in case the above are not found

## Defaults

- `reboot_timeout` is set to `3600` in `vars/main.yml`
- `reboot_os` is set to `true` in `doca_setup.yml`

## Errata

The DPU with a BMC does not currently support cold booting via the BMC without explicitly having an x86 configured. This is something that will be fixed in the future.

Here's the link:

[Blueflield DPU FW Upgrade](https://docs.nvidia.com/networking/display/BlueFieldDPUOSLatest/Deploying+DPU+OS+Using+BFB+from+Host#DeployingDPUOSUsingBFBfromHost-FirmwareUpgradeFirmwareUpgrade)
