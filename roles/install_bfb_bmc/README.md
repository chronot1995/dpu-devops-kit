# Install Bluefield Bitstream Image over BMC

This role will download and install a new BFB image and push it via the BMC to a DPU over the BMC RSHIM interface.

## Dependencies

- Internet access to download the BFB file.
- The RSHIM on the BMC will be enabled and the x86 BMC will be disconnected.

## Defaults

- `doca_bfb` file name defined in `group_vars/all/main.yml`
- `bfb_download_url` URL defined in `group_vars/all/main.yml`
