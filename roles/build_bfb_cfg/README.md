# Build the configuration file for the BFB install

This role creates the bf.cfg file using a Jinja2 template

## Dependencies

This role is used in conjunction with the "install_bfb" role

## Defaults

DPU tmfifo_net0's mac can be specified via rshim_mac. rshim_mac can be specified as the complete 6-byte string ("AA:BB:CC:DD:EE:FF") or as "random". If rshim_mac is specified as "random", a random mac is generated. If rshim_mac is not defined it is computed based on the rshim_num - Tilera OUI-"00:1a:ca:" + "ff:ff"" + (3+(rshim_num*2)).
