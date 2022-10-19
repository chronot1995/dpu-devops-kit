# Create VFs Role

This role sets up VFs on the host_interface. This is useful for testing the containerized applications. 

## Dependencies 
* Requires SR-IOV to be enabled on host

## Overview

Each VF created on the host automatically creates a VF host representor on the DPU that can be used to connect to its own OVS bridge and DOCA app container. (provided to the `create_sf_pair` role or the deploy container roles) The built-in host representors `pf0hpf` and `pf1hpf` can also be used, but VFs are easier to setup/teardown and dedicate to VMs/containers for testing. Each VF created on the host will create a host representor on the DPU in the form `pfXvfY` where X is either 0 or 1 (corresponding to p0 or p1) and Y is the VF number that will map to the VF number on the host.

## Variables
* `num_vfs` - The number of VFs to create. Set to 3 by default
* `physical_function` - The base physical interface (the host sees) for the VFs. If omitted, it'll try to automatically discover and create num_vfs for all BF2 interfaces on the box

The physical function is the interface identifier that the host sees, not the DPU (not p0 or p1). It will be a normal-looking network device name on the host. 

These variables can be set in vars/main.yml, but can work well being passed in as vars or params. Variables passed in this way will override the role variables.

When calling directly as a role, these variables can be set as params this way:
```
  roles:
    - role: create_vfs
      tags: ["create_vfs"]
      # Set base interface on host to create VFs from
      physical_function: enp1s0f0np0
      num_vfs: 2
```

Or at a task level with `vars:` in `include_roles` (calling from inside another role)
```
- name: Create VFs
  include_role:
    name: create_vfs
  vars:
    physical_function: enp1s0f0np0
    num_vfs: 2
```


