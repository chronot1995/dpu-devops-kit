# Build the configuration file for the BFB install

This role creates the bf.cfg file using a Jinja2 template

## Dependencies

This role is used in conjunction with the "install_bfb" role

## Defaults

DPU tmfifo_net0's mac can be specified via rshim_mac. rshim_mac can be specified as the complete 6-byte string ("AA:BB:CC:DD:EE:FF") or as "random". If rshim_mac is specified as "random", a random mac is generated. If rshim_mac is not defined it is computed based on the rshim_num - Tilera OUI-"00:1a:ca:" + "ff:ff"" + (3+(rshim_num\*2)).

There is a new varioable in the group_vars / all / main.yml file:

```
bffwupdate: true
```

If this is uncommented out the following workflow will be available:

1. Install the BFB on the DPU
2. This will automagically trigger a firwmare update
3. Set the DPU into a default state

The above will happen with a single reboot, rather than doing it multiple reboots, as has been the case in the past.
