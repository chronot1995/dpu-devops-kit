# Install Utility Software Role

This installs a number of packages to both x86 and DPU nodes to improve the overall operational experience.

The following packages are installed on both x86 and DPUs:

- VIM
- dnsutils
- [htop](https://htop.dev/)
- [bat](https://github.com/sharkdp/bat)
- tree
- LLDPd
- Git

For x86 nodes the following additional packages are installed:

- pv

For DPU nodes the following additional packages are installed:

- [ctop](https://github.com/bcicen/ctop)

The following settings are modified:

- LLDP settings are modified to advertise correct port names

## Dependencies

- Internet access for Apt and Git
