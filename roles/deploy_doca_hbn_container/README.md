# Deploy DOCA Host Based Networking (HBN) Container

This role deploys the DOCA HBN container on a DPU. 

Use the `poc-doca-hbn.yml` playbook in the project root to deploy this container from scratch.  

See https://docs.nvidia.com/doca/sdk/container-deployment/index.html for more information about deploying DOCA applications as containers.
See https://docs.nvidia.com/doca/sdk/doca-hbn-service/index.html for more information from the DOCA SDK documentation about this service.
See https://catalog.ngc.nvidia.com/orgs/nvidia/teams/doca/containers/doca_telemetry for container documentation on NGC

## Dependencies 
* Requires NGC CLI is installed and configured on target (see `install_ngc_cli` role)
* Requires that containerd is configured properly to pull from NGC registry (nvcr.io) (see `ngc_containerd_setup` role)

## Overview
Host-based networking (HBN) is a DOCA service that enables the network architect to design a network purely on L3 protocols, enabling routing to run on the server-side of the network by using the DPU as a BGP router. The EVPN extension of BGP, supported by HBN, extends the L3 underlay network to multi-tenant environments with overlay L2 and L3 isolated networks.

The HBN solution packages a set of network functions inside a container which, itself, is packaged as a service pod to be run on the DPU. At the core of HBN is the Linux networking DPU acceleration driver. Netlink to DOCA daemon, or nl2docad, implements the DPU acceleration driver. nl2docad seamlessly accelerates Linux networking using DPU hardware programming APIs.

The driver mirrors the Linux kernel routing and bridging tables into the DPU hardware by discovering the configured Linux networking objects using the Linux Netlink API. Dynamic network flows, as learned by the Linux kernel networking stack, are also programmed by the driver into DPU hardware by listening to Linux kernel networking events.

After this role runs, the following commands are useful:
* `crictl ps` - see running containers. May take ~30-60 seconds to download and launch a container
* `/var/log/containers/doca-*` - Logs/diagnostics from the container. useful if container will not launch or exits quickly (Crashloopbackoff)
* `grep kubelet /var/log/syslog` - Logs/diags for kubernetes parsing yaml file and deploying pod/container
* `crictl exec -it <Container ID> /bin/bash` - Log into a running container. Container ID is from `crictl ps`

## Variables
* `container_resources_path` - The path on NGC for the container yaml filed download. Set to `nvidia/doca/doca_container_configs` No need to change/update.
