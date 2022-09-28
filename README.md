# DPU DevOps Kit

This is a collection of Ansible Playbooks that simplifies the deployment and
management of [NVIDIA BlueField-2 DPUs](https://nvda.ws/3rMFfMM).

- [DPU DevOps Kit](#dpu-poc-kit)
  - [Quick Start](#quick-start)
  - [Playbook Descriptions](#playbook-descriptions)
    - [`doca-setup.yml`](#-doca-setupyml-)
    - [`dpdk-setup.yml`](#-dpdk-setupyml-)
    - [`poc-dhcp-server.yml`](#-poc-dhcp-serveryml-)
    - [`poc-doca-ar-container.yml`](#-poc-doca-ar-containeryml-)
    - [`poc-doca-devel-container.yml`](#-poc-doca-devel-containeryml-)
    - [`poc-doca-ips-container.yml`](#-poc-doca-ips-containeryml-)
    - [`poc-doca-telemetry-container.yml`](#-poc-doca-telemetry-containeryml-)
    - [`poc-doca-url-filter-container.yml`](#-poc-doca-url-filter-containeryml-)
    - [`poc-doca-firefly.yml`](#-poc-doca-firefly.yml-)
    - [`poc-doca-dpu-morpheus.yml`](#-poc-doca-dpu-morpheus.yml-)
    - [`poc-doca-hbn.yml`](#-poc-doca-hbn.yml-)
    - [`poc-embedded-mode.yml`](#-poc-embedded-modeyml-)
    - [`poc-grafana.yml`](#-poc-grafanayml-)
    - [`poc-host-restricted-disable.yml`](#-poc-disable-host-restrictedyml-)
    - [`poc-host-restricted-enable.yml`](#-poc-enable-host-restrictedyml-)
    - [`poc-ktls.yml`](#-poc-ktlsyml-)
    - ['poc-link-type-ethernet.yml'](#-poc-link-type-ethernetyml)
    - ['poc-link-type-infiniband.yml'](#-poc-link-type-infinibandyml)
    - [`poc-reinstall-bfb.yml`](#-poc-reinstall-bfbyml-)
    - [`poc-reset-ovs.yml`](#-poc-reset-ovs-)
    - [`poc-separated-mode.yml`](#-poc-separated-modeyml-)
    - ['poc-sshkeys.yml'](#-poc-sshkeys-)
  - [Using the DevOps Kit](#using-the-poc-kit)
    - [Install and Setup Ansible](#install-and-setup-ansible)
    - [Running the initial playbook](#running-the-initial-playbook)
    - [Re-install the BFB / Reset the PoC](#re-install-the-bfb---reset-the-poc)
    - [Optional: DHCP Server Setup](#optional--dhcp-server-setup)
  - [Troubleshooting the DPU-PoC-Kit](#troubleshooting-the-dpu-poc-kit)

## Quick Start

- Clone this repo to a host with Ansible 2.12.x or later / or follow the Automation Container instructions below
- Edit the `hosts` file.
- Set `ansible_user` and `ansible_password` to the username and password on the x86 and DPU endpoints.
- Set `x86 ansible_host=` to the IP of the x86 server.
- Set `dpu_oob ansible_host=` to the IP of the DPU OOB interface.
- Run `ansible-playbook doca-setup.yml`.

## Supported DPU + x86 / host platforms

The DevOps Kit has been tested on the following DPU platforms:

1. Ubuntu 20.04 (DOCA 1.1.x - 1.3.x)

The DevOps Kit has been tested on the following x86 / host platforms:

1. Ubuntu 20.04 (DOCA 1.1.x - 1.3.x)
2. Centos 7.9.x (DOCA 1.2.x)
3. Red Hat Enterprise 8.2 (DOCA 1.2.x)

## Automation Container

One great piece of feedback that we have received is that installing Ansible on various operating systems can lead to version mismatches which are difficult for new Ansible users to troubleshoot and debug. To help resolve this issue, the next few steps will outline how to install an "automation" conatiner which will have all of the needed dependencies for you to succesfully launch the DevOps Kit.

Docker (Linux, Mac, Windows)

1. Follow this [link](https://docs.docker.com/engine/install/) to the install instructions for your platform

2. Pull the container from Docker Hub with the following command:
   `sudo docker pull ipspace/automation:ubuntu`

3. Run the container with following command:
   `sudo docker run -it -d ipspace/automation:ubuntu`

4. Next, log into the container with the following command:
   `sudo docker exec -it $(sudo docker ps | grep -i automation | awk -F" " '{print $1}') bash`

You will see the prompt change to something similar to the following:
`root@032f1ada86f4:/ansible#`

5. Clone the DPU DevOps Kit with the following command:
   `git clone https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit/`

You will see the following output:

```
root@032f1ada86f4:/ansible# git clone https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit/
Cloning into 'dpu-poc-kit'...
warning: redirecting to https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit.git/
remote: Enumerating objects: 614, done.
remote: Counting objects: 100% (193/193), done.
remote: Compressing objects: 100% (133/133), done.
remote: Total 614 (delta 93), reused 75 (delta 34), pack-reused 421
Receiving objects: 100% (614/614), 1.95 MiB | 17.25 MiB/s, done.
Resolving deltas: 100% (248/248), done.
```

6. Change directories into the DevOps Kit:
   `cd dpu-poc-kit`

7. Use vim or nano to edit the "hosts" file in this directory

Change the following settings for the x86:

```
ansible_user=<your x86 username>
ansible_password=<your x86 user password>
ansible_sudo_pass=<your x86 sudo password>
x86 ansible_host=<your x86 IP address>
```

Change the following settings for the DPU:

dpu_oob ansible_host=<your DPU IP address>
Under the `[dpu:vars]` heading, uncomment and change the following:

```
ansible_user=ubuntu
ansible_password=ubuntu
```

8. Test out the Ansible playbook with the following command:

```
ansible all -m ping --become
```

This should produce an output similar to the following:

```
x86 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.8"
    },
    "changed": false,
    "ping": "pong"
}
dpu_oob | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

9. Run the appropriate playbook as outlined in the rest of this README file.

Lima (Open Source Docker replacement for Mac)

1. This is a nice overview of [Lima](https://www.mediaglasses.blog/2021/09/05/docker-desktop-alternatives-for-macos/#lima) with install instructions

2. Start lima with the follwoing command:
   `limactl start`

You will see output similar to the following:

```
INFO[0000] Using the existing instance "default"
INFO[0000] Attempting to download the nerdctl archive from "https://github.com/containerd/nerdctl/releases/download/v0.18.0/nerdctl-full-0.18.0-linux-amd64.tar.gz"  digest="sha256:62573b9e3bca6794502ad04ae77a2b12ec80aeaa21e8b9bbc5562f3e6348eb66"
INFO[0000] Using cache "/Users/mcourtney/Library/Caches/lima/download/by-url-sha256/542daec4b5f8499b1c78026d4e3a57cbe708359346592395c9a20c38571fc756/data"
INFO[0002] [hostagent] Starting QEMU (hint: to watch the boot progress, see "/Users/mcourtney/.lima/default/serial.log")
INFO[0002] SSH Local Port: 60022
```

3. Download the container with the following command:
   `lima nerdctl pull ipspace/automation:ubuntu`

4. Run and login to the container with the following command:
   `lima nerdctl run -it ipspace/automation:ubuntu`

You will see the prompt change to something similar to the following:
`root@032f1ada86f4:/ansible#`

5. Clone the DPU DevOps Kit with the following command:
   `git clone https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit/`

You will see the following output:

```
root@032f1ada86f4:/ansible# git clone https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit/
Cloning into 'dpu-poc-kit'...
warning: redirecting to https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit.git/
remote: Enumerating objects: 614, done.
remote: Counting objects: 100% (193/193), done.
remote: Compressing objects: 100% (133/133), done.
remote: Total 614 (delta 93), reused 75 (delta 34), pack-reused 421
Receiving objects: 100% (614/614), 1.95 MiB | 17.25 MiB/s, done.
Resolving deltas: 100% (248/248), done.
```

6. Change directories into the DevOps Kit:
   `cd dpu-poc-kit`

7. Use vim or nano to edit the "hosts" file in this directory

Change the following settings for the x86:

```
ansible_user=<your x86 username>
ansible_password=<your x86 user password>
ansible_sudo_pass=<your x86 sudo password>
x86 ansible_host=<your x86 IP address>
```

Change the following settings for the DPU:

dpu_oob ansible_host=<your DPU IP address>
Under the `[dpu:vars]` heading, uncomment and change the following:

```
ansible_user=ubuntu
ansible_password=ubuntu
```

8. Test out the Ansible playbook with the following command:

```
ansible-playbook poc-test-inventory.yml
```

This should produce an output similar to the following:

```
x86 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.8"
    },
    "changed": false,
    "ping": "pong"
}
dpu_oob | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

9. Run the appropriate playbook as outlined in the rest of this README file.

Other examples from tools such as Podman are welcome

## Installing Unsigned / Developer Images

Some of the Bluefield-2 cards have "unsigned" or development images that are available to internal NVIDIA resources. Currently, the only way to view if the card is a signed or unsigned / development card is to run the following command from the DPU:

```
sudo mlxbf-bootctl
```

A signed card will have the following:

```
lifecycle state: GA Secured
```

An unsigned / development card will have the following:

```
lifecycle state: GA Non-Secured
or
lifecycle state: Secured (development)
```

The variables to specify the install locations are the following:

`doca_bfb` - the file name of the DOCA image
`bfb_download_url` - the combination of the development URL and the filename

Here is an example of what the command line would look like for a "signed" image install of DOCA 1.3:

```
ansible-playbook doca-setup.yml -e "doca_bfb='DOCA_1.3.0_BSP_3.9.0_Ubuntu_20.04-6.signed.bfb' bfb_download_url='http://www.mellanox.com/downloads/BlueField/BFBs/Ubuntu20.04/DOCA_1.3.0_BSP_3.9.0_Ubuntu_20.04-6.signed.bfb'"
```

## Playbook Descriptions

This collection of playbooks provides the following utilities in the form of [Ansible Roles](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html).

More details on each role can be found in their individual README located within the `roles/` directory.

A set of pre-defined `playbooks` are provided in this root directory.

### `doca-setup.yml`

This is the playbook to get an x86 host and DPU fully ready to run DOCA applications.

- Installs DOCA software on both x86 and DPU
- Installs the DPU BFB image (if `bfb_install` is set to true)
- Sets the x86 Rshim IP address
- Updates the DPU firmware
- Properly configures networking on the DPU and x86 host
- Installs packages to improve the user experience on both x86 and DPU
- Reboots the x86 host

This playbook supports two optional arguments that can be passed as Ansible `extra-vars`

- `x86_reboot` - Set `x86_reboot=false` to skip the server reboot at the end of the playbook. Default is `true`

These arguments are passed with the `-e` flag

```
ansible-playbook doca-setup.yml -e x86_reboot=false -e bfb_install=true
```

### `dpdk-setup.yml`

Sets up the environment for dpdk and checks if the hw can be initialized via testpmd. dpdk libs and testpmd need to be installed separately or via doca-setup.

### `poc-dhcp-server.yml`

Configures an Ubuntu server to be a DHCP server with ISC-DHCP. This is a basic configuration designed to help with POC/lab environments.

### `poc-doca-all-containers.yml`

Deploys 3x VFs on the host and all of the NGC containers on the DPU. Will prompt for NGC credentials and org if NGC is not installed and configured.

### `poc-doca-ar-container.yml`

Deploys the Application Regcogition container from NGC. Will prompt for NGC credentials and org if NGC is not installed and configured.  
More info here: https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_application_recognition

### `poc-doca-devel-container.yml`

Deploys the DOCA development container from NGC. Will prompt for NGC credentials and org if NGC is not installed and configured.  
More info here: https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca

### `poc-doca-ips-container.yml`

Deploys the IPS container from NGC. Will prompt for NGC credentials and org if NGC is not installed and configured.  
More info here: https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_ips

### `poc-doca-telemetry-container.yml`

Deploys the DOCA Telemetry container from NGC. Will prompt for NGC credentials and org if NGC is not installed and configured.  
More info here: https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_telemetry

### `poc-doca-url-filter-container.yml`

Deploys the URL Filter container from NGC. Will prompt for NGC credentials and org if NGC is not installed and configured.  
More info here: https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_url_filter

### `poc-embedded-mode.yml`

Enables embedded mode on the DPU.

### `poc-doca-firefly.yml`

Deployes the DOCA Firefly PTP container. This changes your DPU to separated host mode and is not currently compatible with other embedded mode DPU use cases and functions.

### `poc-doca-dpu-morpheus.yml`

Deploys the DOCA flow inspector and DOCA telemetry service to point to a Morpeus AI Engine using fluentd.

### `poc-doca-hbn.yml`

Deploys the DOCA HBN (Host Based Networking) Service on the DPU. DOCA HBN provides classic top of rack (ToR) routing/switching/network overlay capabilities on the DPU for the host.

### `poc-grafana.yml`

Configures and deploys the Grafana Cloud monitoring agent unto the DPU

### `poc-host-restricted-disable.yml`

Disables restricted mode on the DPU.

### `poc-host-restricted-enable.yml`

Enables restricted mode on the DPU.

### `poc-ktls.yml`

Builds and installs openssl and associated ktls enabled applications for demonstrating ktls offload

### 'poc-link-type-ethernet.yml'

Enable the Ethernet link type for the DPU

### 'poc-link-type-infiniband.yml'

Enable the Infiniband link type for the DPU

### `poc-nic-mode-enable.yml`

Disables NIC mode / Connect X mode on the DPU.

### `poc-nic-mode-disable.yml`

Disables NIC mode / Connect X mode on the DPU.

### `poc-reinstall-bfb.yml`

Installs a fresh BFB image, networking, and utility software to the DPU

### `poc-reset-ovs.yml`

Delete, re-add, and reset Open VSwitch / OVS on the DPU. This is an easier step than reinstalling the BFB

### `poc-separated-mode.yml`

Enables separated mode on the DPU.

### 'poc-sshkeys.yml'

Installs the SSH Keys on the DPU and x86 for passwordless authentication

## Using the DevOps Kit

### Install and Setup Ansible

Identify a host that will run Ansible. This can be an external host or the x86 host with the DPU.
Run the following steps on that selected server.

1. Install SSHPass

```
sudo apt-get install sshpass
```

2. First, run the following command on the Ansible server to download this repo:

```
git clone https://gitlab.com/nvidia/networking/bluefield/dpu-poc-kit
```

3. Change directories into the dpu-poc-kit directory:

```
cd dpu-poc-kit
```

4. Create a python Virtual Environment

```
python3 -m venv venv
source venv/bin/activate
```

**Note** if you need to re-activate the virtual environment use the following command
`source venv/bin/activate`

5. Install Ansible

```
pip3 install --upgrade pip
pip3 install setuptools-rust
python3 -m pip install ansible paramiko
```

6. Update the usernames, passwords and IP addresses in the `hosts` file. (This is also called the Anisble Inventory File)

- `ansible_user` is the username used for SSH.
- `ansible_password` is the password used for SSH.
- `ansible_sudo_pass` is the sudo password for the SSH user.
- `x86 ansible_host` is the IP address to access the x86 host that has a DPU installed. If you are running Ansible from the x86 host, use `127.0.0.1`
- `dpu_oob ansible_host` is the IP address of the DPU out of band ethernet interface.

**(optional)** If you intend on deploying DOCA service containers, you can provide your NGC API Key and Group in the inventory file. If you do not provide it in the inventory, you will be prompted for input the middle of the playbook.

```
ngc_api_key=""
ngc_org=""
```

**(optional)** For the DPUs in your inventory, define a variable "parent_host" that refers to the inventory name of the server where this DPU is installed. This is optional, but if defined properly will allow for `mlxconfig` changes to take effect WITHOUT THE NEED FOR A COLD REBOOT/POWER CYCLE

```
[x86_hosts]
x86 ansible_host=10.150.170.174  # host is named x86 in the inventory

<snip>

[dpus]
dpu_oob ansible_host=10.150.106.174 parent_host=x86 #  so my parent_host variable refers to that name, 'x86'
```

7. (Optional) If you wish to install DOCA components download DOCA software packages

- Download the DOCA file for x86 from `https://developer.nvidia.com/networking/secure/doca-sdk/doca_1.11/doca_111_b19/ubuntu2004/doca-host-repo-ubuntu2004_1.1.1-0.0.1.1.1.024.5.4.2.4.1.3_amd64.deb` and place the file in `roles/install_server_doca/files`.
- Download DOCA the file for DPU from `https://developer.nvidia.com/networking/secure/doca-sdk/doca_1.11/doca_111_b19/doca-repo-aarch64-ubuntu2004-local_1.1.1-1.5.4.2.4.1.3.bf.3.7.1.11866_arm64.deb` and place the file in `roles/install_dpu_doca/files`.

### Running the initial playbook

1. Verify that Ansible is working properly.

```
ansible x86 -m ping --become
```

**Note** if this step fails, look at the `Troubleshooting` section at the end of this page for help.

2. Install DOCA by running the `doca-setup.yml` playbook:

```
ansible-playbook doca-setup.yml
```

### Re-install the BFB / Reset the PoC

Reset the BF back to the factory defaults after running one of the BF use cases. This playbook is the minimum needed to accomplish that without going through the plays for the various components of the full PoC:

```
ansible-playbook poc-reinstall-bfb.yml
```

### Optional: DHCP Server Setup

_This was tested using an Ubuntu 20.04 server as the DHCP server._

1. Edit the `hosts` file

- Uncomment `dhcpserver ansible_host` and set the IP address of the DHCP server.
- Uncomment `oob_mac` and set the MAC address of the out of band ethernet interface of the DPU.
- (Optional) If you have a BMC interface that will receive a DHCP IP uncomment `bmc_mac` and `bmc_ip` and set the IP and MAC address of the BMC interface.

2. Edit the `group_var/all/main.yml` file

- Set `dhcp_network` to be the subnet the DHCP server will assign IPs from.

3. Run the following command to build the DHCP server:

```
ansible-playbook poc-dhcp-server.yml
```

## Troubleshooting the DPU-PoC-Kit

1. Confirm basic Ansible connectivity.
   For this to work the IP addresses, `ansible_user` and `ansible_password` values must be correct.
   **Note** if the DPU has not been provisioned failure is expected.

Run the command:

```
ansible all -m ping
```

This should produce an output similar to the following:

```
x86 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.8"
    },
    "changed": false,
    "ping": "pong"
}
dpu_oob | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

2. Confirm sudo access.
   For this to work the `ansible_sudo_pass` value must be correct.
   **Note** if the DPU has not been provisioned failure is expected.

```
ansible all -m ping --become
```

This should produce an output similar to the following:

```
x86 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.8"
    },
    "changed": false,
    "ping": "pong"
}
dpu_oob | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```

If this fails or just hangs, you may need to enable [passwordless sudo](https://code-maven.com/enable-ansible-passwordless-sudo)

Use `sudo visudo` and change the line  
`%sudo ALL=(ALL:ALL) ALL`  
to  
`%sudo ALL=(ALL:ALL) NOPASSWD: ALL`

3. Confirm gathering facts.
   This confirms that Ansible can connect to the DPU and read information from the DPU and x86 nodes.
   **Note** if the DPU has not been provisioned failure is expected.

```
ansible all -m setup
```

The output should be a few pages long and similar to the following:

```
dpu_oob | SUCCESS => {
    "ansible_facts": {
        "ansible_all_ipv4_addresses": [
            "192.168.100.2",
            "10.10.150.202"
        ],
        "ansible_all_ipv6_addresses": [
            "fe80::21a:caff:feff:ff01",
            "fe80::bace:f6ff:febc:7c92"
        ],
        "ansible_apparmor": {
            "status": "enabled"
        },
...
```
