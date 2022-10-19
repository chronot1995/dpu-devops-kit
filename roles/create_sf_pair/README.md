# Create SF Pair Role

This role sets up two SFs on the DPU for a DOCA NGC container and plumbs it up to OVS. It is normally meant to be included in other roles to deploy a specific container

## Overview

This role needs two SF numbers and a host facing interface (representor). This role will automatically infer the egress physical interface from the host_interface variable (pf1hpf is physical function 1 or p1 interface. pf0vf2 is physical function 0 or p0 interface). This role will create two SFs of the inferred physical function if they do not already exist. Then, this role will plumb up the SFs to OVS. The host_interface and one SF will go into a newly created OVS bridge, and the other SF will be placed into the OVS bridge that the physical interface is already in.

Traffic will not flow until a container (doca app) is running to connect the two SFs together and provide a path from the host interface to the physical interface through the DOCA app and 2x OVS bridges.

## Variables
This role requires three user provided variables
* `sf1_num`
* `sf1_num`
* `host_interface`

These variables can be set in vars/main.yml, but can work well being passed in as vars or params. Variables passed in this way will override the role variables.

When calling directly as a role, these variables can be set as params this way:
```
    - role: create_sf_pair
      tags: ["create_sf_pair"]
      sf1_num: 11
      sf2_num: 21
      host_interface: pf0vf1
```

Or at a task level with `vars:` in `include_roles` (calling from inside another role)
```
- name: Create two SFs
  include_role:
    name: create_sf_pair
  vars:
    sf1_num: 10
    sf2_num: 11
    host_interface: pf0hpf
```


