# Remove all configured OVS bridges

This role will remove, re-add, and restart OVS in order to remove any custom / testing OVS rules.

## Dependencies

- None

## Defaults

- None

## Example OVS command on the DPU:

```
sudo ovs-ofctl add-flow ovsbr1 dl_type=0x806,nw_proto=1,actions=flood
```

```
ubuntu@localhost:~$ sudo ovs-ofctl dump-flows ovsbr1 | grep -i flood
 cookie=0x0, duration=39.993s, table=0, n_packets=0, n_bytes=0, idle_age=39, arp,arp_op=1 actions=FLOOD
```
