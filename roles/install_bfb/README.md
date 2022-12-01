# Install Bluefield Bitstream Image

This role will download and install a new BFB image to a DPU via the x86 RSHIM interface.

## Dependencies

- Internet access to download the BFB file.
- RSHIM accessible and installed on the x86 host.

## Defaults

- `doca_bfb` file name defined in `vars/main.yml`
- `bfb_download_url` URL defined in `vars/main.yml`
- `dev_doca_bfb` file name for a development in `group_vars/all/main.yml` This variable will need to be adjusted to a specific development BFB
- `dev_bfb_download_url` URL defined in `group_vars/all/main.yml` This variable will need to be adjusted to a specific development URL
