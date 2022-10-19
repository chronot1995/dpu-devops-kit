# Setup containerd for NGC role

This role sets up the containerd service on the DPU to be able to authenticate to and pull containers directly from nvcr.io. Needed to be able to have kubelet deploy doca pods via yaml config files

For more information, see: https://docs.nvidia.com/doca/sdk/container-deployment/index.html#configure-ngc-credentials-on-bluefield

## Dependencies 
* Internet access on target machine
* NGC API key provided or have a properly working NGC CLI install

## Overview
This role will setup containerd to be able to pull directly from NGC. It performs a docker login with the NGC API key and then pulls an auth token derived from the NGC API key and modifies `/etc/containerd/config.toml` to be able to authenticate to nvcr.io (NGC container registry)

This role should be run before the container deploy roles.

## Variables
* `ngc_api_key` - needed to generate auth token. if NGC is working, it is pilfered from the ngc config file
