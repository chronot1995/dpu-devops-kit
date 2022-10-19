# Install NGC CLI role

This role installs and configures NGC CLI on the DPU or on a host. The NGC CLI is used to automate deployment of the DOCA NGC containers.

See https://ngc.nvidia.com/setup/installers/cli for more information about installing the NGC CLI  

## Dependencies 
* Internet access on target machine

## Overview
This role will setup the NGC CLI if it is not already installed and configured. It requires an NGC API key. See more info about generating an NGC API key here: https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key  

If NGC is installed and setup already on the target machine, it will not change the configuration/user/authentication for NGC.

## Variables
* `ngc_api_key` - This does not need to be set as a variable or passed it, but it can be. **If not provided, it will be prompted for in the middle of the play**
* `ngc_org` - An organization that you belong to on NGC. Log into NGC to determine this. If not
* `force_install_ngc_cli` - Default set to false. Set to true if you want to force reinstall of NGC CLI
* `force_configure_ngc` - Default set to false. Set to true if you want to force a new NGC config file to be generated and dropped in
