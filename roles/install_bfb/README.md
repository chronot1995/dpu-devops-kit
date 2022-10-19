# Install Bluefield Bitstream Image
This role will download and install a new BFB image to a DPU via the x86 RSHIM interface.

## Dependencies
* Internet access to download the BFB file.
* RSHIM accessible and installed on the x86 host.
* `doca_bfb` file name defined in `vars/main.yml
* `bfb_download_url` URL defined in `vars/main.yml

## Defaults
* BFB filename `DOCA_v1.2.1_BlueField_OS_Ubuntu_20.04-5.4.0-1023-bluefield-5.5-2.1.7.0-3.8.5.12027-1.signed-aarch64.bfb`
* Download URL `http://www.mellanox.com/downloads/BlueField/BFBs/Ubuntu20.04/`

