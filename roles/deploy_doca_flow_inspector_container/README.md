# Deploy DOCA Flow Inspector Container role

This role deploys the DOCA Flow Inspector on a DPU.

Typically this role isn't used to deploy the flow inspector as a standalone service.

The flow inspector service is linked to the DOCA telemetry service (DTS). The flow inspector receives mirrored packets from the user. It then parses and forwards the data to the DTS which gathers predefined statistics forwarded by various providers/sources. The flow inspector uses the DOCA telemetry API to initiate a communication channel to the DTS while the DPDK infrastructure allows acquiring packets at a user-space layer.

See https://docs.nvidia.com/doca/sdk/container-deployment/index.html for more information about deploying DOCA applications as containers. 
See https://docs.nvidia.com/doca/sdk/doca-flow-inspector-service/index.html for more informaion about this service in our DOCA SDK documentation.
See https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_flow_inspector for container documentation on NGC

## Dependencies 
* Requires NGC CLI is installed and configured on target (see `install_ngc_cli` role)
* Requires that containerd is configured properly to pull from NGC registry (nvcr.io) (see `ngc_containerd_setup` role)

## Overview

This role will fetch the container kubelet file from NGC and prepare the system to have k8s deploy the container on the DPU. This role modifies the yaml file according to the system environment and allows k8s to deploy the container as a pod.

After this role runs, the following commands are useful:
* `crictl ps` - see running containers. May take ~30-60 seconds to download and launch a container
* `/var/log/containers/doca-*` - Logs/diagnostics from the container. useful if container will not launch or exits quickly (Crashloopbackoff)
* `grep kubelet /var/log/syslog` - Logs/diags for kubernetes parsing yaml file and deploying pod/container
* `crictl exec -it <Container ID> /bin/bash` - Log into a running container. Container ID is from `crictl ps`
