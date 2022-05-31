# Release Notes

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
2. Provided more details for those who are new to Git and how to clone the PoC Kit and what files to edit for your specific deployment
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
