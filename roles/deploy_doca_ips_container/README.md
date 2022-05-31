# Deploy DOCA IPS Container role

This role deploys the DOCA IPS container on a DPU.

Use the `poc-doca-ips-container.yml` playbook in the project root to deploy this container from scratch.  

See https://docs.nvidia.com/doca/sdk/container-deployment/index.html for more information about deploying DOCA applications as containers.  
See https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_ips for container documentation on NGC

## Dependencies 
* Requires NGC CLI is installed and configured on target (see `install_ngc_cli` role)
* Requires that containerd is configured properly to pull from NGC registry (nvcr.io) (see `ngc_containerd_setup` role)

## Overview

This role will fetch the container kubelet file from NGC and prepare the system to have k8s deploy the container on the DPU. Each container has slightly different requirements, so a role exists for each NGC container deployment. This container requires two scalable functions, a compiled signature file, and some dpdk prerequistes to be setup. This role modifies the yaml file according to the system environment and allows k8s to deploy the container as a pod.

After this role runs, the following commands are useful:
* `crictl ps` - see running containers. May take ~30-60 seconds to download and launch a container
* `/var/log/containers/doca-*` - Logs/diagnostics from the container. useful if container will not launch or exits quickly (Crashloopbackoff)
* `grep kubelet /var/log/syslog` - Logs/diags for kubernetes parsing yaml file and deploying pod/container
* `crictl exec -it <Container ID> /bin/bash` - Log into a running container. Container ID is from `crictl ps`

## Variables
* `container_resources_path` - The path on NGC for the container yaml filed download. Set to `nvidia/doca/doca_container_configs` No need to change/update.
* `host_interface` - The host representor interface that we want to attach the container to. Used to infer the egress (physical function) interface. Will be placed in its own ovs bridge. 
* `sf1_num` - The first SF number for the application. Set to unique default value. Not required to set or override.
* `sf2_num` - The second SF number for the application. Set to unique default value. Not required to set or override.
* `aux_device_num1` - normally autodetected and set by included create_sf_pair role. Not typically required to be set. Used to modify container yaml file for kubelet
* `aux_device_num2` - normally autodetected and set by included create_sf_pair role. Not typically required to be set. Used to modify container yaml file for kubelet

The physical function is the interface identifier that the host sees, not the DPU (not p0 or p1). It will be a normal-looking network device name on the host. 

These variables can be set in vars/main.yml, but can work well being passed in as vars or params. Variables passed in this way will override the role variables.

When calling directly as a role, these variables can be set as params this way:
```
    # Deploy DOCA IPS container connected to pf0hpf and p0
    - role: deploy_doca_ips_container
      tags: ["deploy_doca_ips"]
      # Set/override role variables
      sf1_num: 22
      sf2_num: 23
      host_interface: pf0hpf
```
