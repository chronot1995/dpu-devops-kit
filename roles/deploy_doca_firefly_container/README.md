# Deploy DOCA Firefly Role (NOT A SUPPORTED SERVICE AS OF DOCA 1.3)

This role deploys the DOCA Firefly timing service container on a DPU. This service is not yet available in the public NGC catalog.

Use the `poc-doca-firefly-container.yml` playbook in the project root to deploy this container from scratch.  

See https://docs.nvidia.com/doca/sdk/container-deployment/index.html for more information about deploying DOCA applications as containers.  

## Dependencies 
* Requires NGC CLI is installed and configured on target (see `install_ngc_cli` role)
* Requires that containerd is configured properly to pull from NGC registry (nvcr.io) (see `ngc_containerd_setup` role)

## Overview

This role only deploys the firefly container from NGC. This role is EA.
