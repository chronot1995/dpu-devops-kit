# Create SF Role

This role sets up a single SF on a DPU. It is normally meant to be included in other roles to deploy a specific container


## Overview

This role needs a 

## Variables
This role requires two key variables be set.
* `sf_num` - aribtrary number for the scalable function. 44 seems like a good number
* `pfnum` - The physical function number to create the SF from. This is typically 1 or 0

These variables can be set in vars/main.yml, but can work well being passed in as vars or params or iwth `-e` on the ansible-playbook command line. Variables passed in this way will override the role variables.

When calling directly as a role, these variables can be set as params this way:
```
    - role: create_sf
      tags: ["create_sf"]
      sf_num: 44
      pfnum: 0
```

Or at a task level with `vars:` in `include_roles` (calling from inside another role)
```
- name: Create an SF
  include_role:
    name: create_sf
  vars:
    sf_num: 44
    pfnum: 0
```


