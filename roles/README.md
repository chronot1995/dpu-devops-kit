# DPU DevOps Kit Roles

Each folder in this directory provides configuration and files to preform DPU or x86 configuration and administration tasks.

Each directory is designed to be a reusable component and does not have any outside dependencies.

- `bmc_board_type` - identifies a production vs development BMC board
- `build_bfb_cfg` - create the bf.cfg file for a DOCA install via the host rshim
- `check_device_up` - check to see if a device is responding before moving onto the next play
- `create_sf` - create Scalable Functions on the DPU
- `create_sf_pair` - create Scalable Function pairs on the DPU
- `create_vfs` - Component to create Virtual Functions on the DPU
- `deploy_doca_ar_container` - Deploys the Application Recognition container from NGC
- `deploy_doca_devel_container` - Deploys the DOCA development container from NGC
- `deploy_doca_firefly_container` - Deploys the DOCA Firefly container from NGC
- `deploy_doca_flow_inspector_container` - Deploys the DOCA Flow Inspector container from NGC
- `deploy_doca_hbn_container` - Deploys the DOCA HBN container from NGC
- `deploy_doca_ips_container` - Deploys the IPS container from NGC
- `deploy_doca_telemetry_container` - Deploys the DOCA Telemetry container from NGC
- `deploy_doca_url_filter_container` - Deploys the URL Filter container from NGC
- `deprecated` - a folder containing deprecated playbooks and components
- `dhcp_server` - A basic `isc-dhcp` setup for lab environments.
- `dpu_custom_facts` - Custom DPU facts that are used in advanced PoCs
- `embedded_mode` - Enables DPU "Embedded" mode through the use of [MST](https://docs.mellanox.com/display/MFTv4160/Mellanox+Software+Tools+%28mst%29+Service)
- `grafana-monitoring` - Monitor the DPU via Grafana Cloud
- `install_additional_software` - This is additional software that can be installed on the DPU and customized for each PoC
- `install_bfb` - Downloads and installs the BlueField BFB image over the RSHIM interface.
- `install_bfb_bmc` - Downloads and installs the BlueField BFB image over the BMC RSHIM interface.
- `install_dpu_doca` - Installs the DOCA components on a BlueField-2 DPU.
- `install_dpu_dpdk` - Setup "hugepages" and verifies testpmd
- `install_ngc_cli` - Installs the NGC CLI onto the DPU
- `install_server_dnsmasq` - Playbook to NAT the DPU`s egress traffic from the rshim interface
- `install_server_doca` - Installs the DOCA components on an Ubuntu 20.04 x86 host.
- `install_utility_software` - Installs packages and configurations to improve the user experience.
- `ktls` - KTLS offload proof of concept
- `link_type_ethernet` - Enable Ethernet on the DPU
- `link_type_infiniband` - Enable Infiniband on the DPU
- `manage_bf2_fw` - Checks and updates DPU Firmware to the latest version.
- `ngc_containerd_setup` - Component to setup and configure Containerd and Docker on the DPU
- `nic_mode_disable` - Disables the DPU "NIC Mode" / ConnectX mode
- `nic_mode_enable` - Enables the DPU "NIC Mode" / ConnectX mode
- `networking` - Configures the IP address of the x86 and the DPU rshim
- `onward` - An internal utility to handle "Yes/No" user input.
- `precheck` - Verifies the x86 is supported by the DevOps Kit
- `reboot_os` - A rewrite of the reboot_os module that will reboot the DPU, the DPU's BMC, or the host BMC
- `remove_ovs` - Removes all configured OVS bridges.
- `reset_dpu_configuration` - Resets BF FW to factory defaults
- `reset_ovs` - Remove, re-add, and restarts OVS. This effectively clears OVS without reinstalling the BFB
- `restricted_mode_disable` - Disables DPU restricted mode, returning the DPU to the default `privileged` mode.
- `restricted_mode_enable` - Enables DPU restricted mode.
- `rshim_check` - Verify connectivity to the DPU RSHIM
- `separated_mode` - Configures the DPU in `Separated Mode`.
- `sshkeyscreate` - creates SSH keys on the DPU and the x86 host
- `sshkeysinstall` - installs the corresponding SSH keys on the DPU and the x86 host
- `try_mlxfwreset_warmboot` - uses the mlxfwreset to reboot the DPU
