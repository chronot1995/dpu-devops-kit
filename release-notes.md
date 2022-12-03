# Release Notes

### 12/3/2022

1. Added DOCA 1.5.1 support
2. Updated the x86 packages for DOCA 1.5.1. As part of any major or minor release, the following will need to be updated:
   i. group_vars/all/main.yml -> add the updated link to the new DOCA BFB file
   ii. roles/install_server_doca/vars -> add an updated Ubuntu and RHEL deb / rpm for the x86 install packages
   iii. roles/install_dpu_doca/vars - add an updated Ubuntu deb for the ARM / DPU install packages
3. Updated the doca-setup.yml to set Ethernet for VPI cards
4. Updated the poc-reinstall-bfb.yml to use the same plays as the doca-setup.yml

### 12/1/2022

1. Added a VPI card check to the Ethernet and Infiniband roles
2. Updated the reboot role for HBN
3. Added links in the project README to the specific READMEs for the various roles
4. Documentation updates

### 11/11/2022

1. Added DOCA 1.5.0 support
2. Added support for Ubuntu 22.04 and Rocky 8.6 as a supported host operating system. This will require additional testing around Rocky Linux.
3. Consolidate DOCA download links into the group_vars / all / main.yml for the install_bfb and install_bfb_bmc roles
4. Updated the x86 packages for DOCA 1.5.0. As part of any major or minor release, the following will need to be updated:
   i. group_vars/all/main.yml -> add the updated link to the new DOCA BFB file
   ii. roles/install_server_doca/vars -> add an updated Ubuntu and RHEL deb / rpm for the x86 install packages
   iii. roles/install_dpu_doca/vars - add an updated Ubuntu deb for the ARM / DPU install packages
5. Added the ability to use a development BFB over the host rshim without passing command-line arguments. Details in the README and in the inventory file
6. Consolidated "build_bfb_cfg" and "build_bfb_cfg_bmc" roles into "build_bfb_cfg"
7. Created the "sfcenabled" global variable which configures the DPUs for an SFC DOCA installation. This is configured in the group_vars > all > main.yml location
8. Paused the plays to give the rshim more time to start during a DOCA install
9. Reworked the "check_device_up" role based on a host-based install
10. Timeout fixes to the bfb_install_bmc roles

### 10/29/2022

1. Added support for installing DOCA over the DPU BMC of compatible cards
2. Added a new role to identify a production vs development BMC card
3. Added a new "build_bfb_cfg_bmc" role to build a pared down bf.cfg for a DOCA install over the BMC's rshim
4. Added a new "check_device_up" role that can be used for Python and / or non-Python compatible devices by adding the "delegate_to: localhost" for the non-Python compatible devices, such as a DPU's BMC
5. Moved the legacy "reboot_os" role into the deprecated folder and renamed the "reboot_os_redux" to "reboot_os"
6. Updated the host file to clearly delinate the sections of the configuration
7. Updated the roles README file and the project README file

### 10/4/2022

1. Added a new reboot role called "reboot_os_redux"
2. This new role will reboot the onboard BMC / iDRAC when enabled or let the user know that they need to do a cold boot to apply changes.
3. This is an EA feature and will continue to be vetted and revised
4. Updated the docs for this feature as it has some specific requirements around group names in order to work properly

### 8/24/2022

1. Added a template-based configuration for the bf.cfg file generation
2. Early Access: Added support for updating a DPU via the onboard BMC.
3. Separated the extra DPU software between the existing "install_utility_software" role and the "install_additional_software" role
4. Added a timezone variable for the additional software at the group_vars level for easier access
5. Inventory test playbook for troubleshooting purposes

### 8/3/2022

1. Changed the name of the project from the "DPU PoC Kit" to the "DPU DevOps Kit"
2. Added DOCA 1.4.0 support
3. Updated the server side / x86 packages for DOCA 1.4.0. As part of any major or minor release, the following will need to be updated:
   i. roles/install_bfb/vars -> add the updated link to the new DOCA BFB file
   ii. roles/install_server_doca/vars -> add an updated Ubuntu and RHEL deb / rpm for the x86 install packages
   iii. roles/install_dpu_doca/vars - add an updated Ubuntu deb for the ARM / DPU install packages
4. Added support to change the link type for both ports to Ethernet
5. Added support to change the link type for both ports to Infiniband

### 7/27/2022

1. Added reset-ovs role to remove, re-add, and reset OVS on the DPU
2. Documentation misc updates

### 6/2/2022

1. Added support to enable NIC / ConnectX mode
2. Added support to disable NIC / ConnectX mode
3. Renamed the Restricted Host mode playbooks to use the same format as the NIC mode playbooks.
4. Started a "Cheat Sheet" markdown page that can be used to record tips / tricks / troubleshooting for the DPU

### 5/19/2022

1. Added support for Host-Based Networking (HBN)
2. Added support for installing Morpheus onto the DPU
3. Added support for Firefly
4. Added NGC CLI commands into the inventory file
5. Added passwordless support with the SSH Key exchange roles
6. Added documentation to install unsigned / development BFB images
7. Improved Warm Boot on the DPU

### 5/10/2022

1. Added DOCA 1.3.0 support
2. Updated the server side / x86 packages for DOCA 1.3.0. As part of any major or minor release, the following will need to be updated:
   i. roles/install_bfb/vars -> add the updated link to the new DOCA BFB file
   ii. roles/install_server_doca/vars -> add an updated Ubuntu and RHEL deb / rpm for the x86 install packages
   iii. roles/install_dpu_doca/vars - add an updated Ubuntu deb for the ARM / DPU install packages

### 5/2/2022

New Features:

1. Prompt for bfb install rather than passing a variable.
2. Centos 7, RHEL 8.2, and Ubuntu 20.04 verified
3. Reset the firmware as well as BFB install
4. Precheck of the x86 hosts to verify they are one of the supported hosts from #2.
5. PoC reinstall contains the firmware reset
6. Check status of the rshim outside of the networking role. Basically making it a python-ish function in Ansible

Fixes:

1. Upstream fixes to the Ubuntu automation container now contains ping, vim, and nano
2. Changed the executable in the "install_bfb" role to /bin/bash
3. YAML Fixes to all PoC playbook files.
4. Added and commented out the option to prevent "skipped" plays from being displayed in the ansible.cfg

### 4/20/2022

1. Hat tip to Charu! Went through the poc-\*.yml files and changed all of the "dpu_oob" entries to the "dpus" group
2. Updated all of the poc-\*.yml files to gather facts as part of the NGC CLI installation role

### 4/8/2022

1. Imported the networking variables into the install_bfb role. This will allow us to check the IP address of the rshim variable after the BFB is installed
2. Fixed an issue where the first DPU had to be named "dpu_oob" in order to set the password correctly via the BFB installer. Now, any DPU name will work.
3. README file doc updates around the new automation container
4. Host file doc updates

### 04/5/2022

1. Added a new section to the "README" file on how to instatiate an Automation Container using Docker or Lima. This will provide a base platform for running Ansible with the necessary dependencies
2. Provided more details for those who are new to Git and how to clone the DevOps Kit and what files to edit for your specific deployment
3. Created a "deprecated" folder under "roles" to clean up the repo
4. Fixed the "poc-reinstall-bfb.yaml" playbook to align with the new networking role
5. Edited the "README" file under the roles directory to reflect all of the currently defined roels
6. Edited the repo "README" file and removed the reference to the old BFB install process
7. Fixed the RHEL networking role to use the local x86 and DPU variables file

### 03/31/2022

1. Updated the server side / x86 packages for DOCA 1.2.1. As part of any major or minor release, the following will need to be updated:
   i. roles/install_bfb/vars -> add the updated link to the new DOCA BFB file
   ii. roles/install_server_doca/vars -> add an updated Ubuntu and RHEL deb / rpm for the x86 install packages

### 03/30/2022

1. Added a new networking role which allows the user to set the IP address for the x86 and the rshim.
2. This role is now incorporated into the doca-setup.yml playbook and workflow with the currently supported 192.168.100.0/30 IP range

### 1/31/2022

1. Added DOCA 1.2.1 support

### 1/24/2022

Fixed:

1. Added dpu section for the poc-reinstall playbook
2. Fixed tag name in the doca-setup.yml playbook

### 12/28/2021

1. New roles and playbooks to support deploying public NGC DOCA containers to the DPU. See each role README for more instructions

### 12/8/2021

1. Fixed the "extra-vars" command in the README file
2. Added the DOCA 1.1 / BFB 3.7.1 URLs as commented out variables in the install_dpu_doca and install_bfb roles

### 11/22/2021

1. Added support for DOCA setup and install
2. Add utility software role for x86 and DPU
3. Large documentation expansion
4. Renamed a number of roles and playbooks to make their use more obvious.

Fixed:

1. Setting Restricted mode now works.

### 10/29/2021

Completed - New Feature:

1. Added a new BMC MAC address and BMC IP address for the DHCP Server playbook

Fixed:

1. Rewrote the code for a RedHat compatible tmfifo interface
2. Rewrote the code for an Ubuntu compatible tmfifo interface

### 10/27/2021

Completed - New Features:

1. Enabled RedHat install for the OFED drivers via yum
2. Added the print_facts.yml file from the NDO collection
3. Updated the README doc with additional troubleshooting

### 10/20/2021

Completed - New Features:

1. Enable + disable restricted / isolated mode on the DPU
2. Prompt the user for a "y/n" question before each of the PoC playbooks
3. The DHCP server configuration is now an optional play in case you have BF2s that are already IP'd
4. The PoC-Kit will no longer download the DOCA / BFB each time
5. Updated the README file

Bugs fixed:

1. Fixed an issue where there would be a failure to remove OVS bridges when running Separated mode twice or if it was run right after the reinstall. There is now failure logic built in to avoid this.
