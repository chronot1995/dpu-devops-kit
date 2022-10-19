# Deploy DOCA Devel Container role

This role deploys the DOCA devel container on a DPU. This container is designed primarily for use as a development environment.

Use the `poc-doca-devel-container.yml` playbook in the project root to deploy this container from scratch.  

See https://docs.nvidia.com/doca/sdk/container-deployment/index.html for more information about deploying DOCA applications as containers.  
See https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca for container documentation on NGC

## Dependencies 
* Requires NGC CLI is installed and configured on target (see `install_ngc_cli` role)
* Requires that containerd is configured properly to pull from NGC registry (nvcr.io) (see `ngc_containerd_setup` role)

## Overview

This role will fetch the container kubelet file from NGC and prepare the system to have k8s deploy the container on the DPU. Each container has slightly different requirements, so a role exists for each NGC container deployment. 

After this role runs, the following commands are useful:
* `crictl ps` - see running containers. May take ~30-60 seconds to download and launch a container
* `/var/log/containers/doca-*` - Logs/diagnostics from the container. useful if container will not launch or exits quickly (Crashloopbackoff)
* `grep kubelet /var/log/syslog` - Logs/diags for kubernetes parsing yaml file and deploying pod/container
* `crictl exec -it <Container ID> /bin/bash` - Log into a running container. Container ID is from `crictl ps`

## Variables
* `container_resources_path` - The path on NGC for the container yaml filed download. Set to `nvidia/doca/doca_container_configs` No need to change/update.
