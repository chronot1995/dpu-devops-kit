# Configure the x86 IP address for the DPU RSHIM interface
This role applies the default IP address for the RSHIM interface on the x86 host.
Both Ubuntu and RedHat Linux are supported.

## Dependencies
* RSHIM driver is installed and active.

## Defaults
* Applies the IP address `192.168.100.1/30` to the x86 `tmfifo_net0` interface
* Applies the IP address '192.168.100.2/30' to the DPU 'tmfifo_net0' interface
