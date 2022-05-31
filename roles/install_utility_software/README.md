# Install Utility Software Role
This installs a number of packages to both x86 and DPU nodes to improve the overall operational experience.   

The following packages are installed on both x86 and DPUs:
* VIM
* dnsutils
* [htop](https://htop.dev/)
* [bat](https://github.com/sharkdp/bat)
* tree
* LLDPd
* [Chrony](https://chrony.tuxfamily.org/)
* [Powerline Fonts](https://github.com/powerline/fonts)
* [ZSH](https://en.wikipedia.org/wiki/Z_shell)
* sshpass
* Git
* [Oh My ZSH](https://ohmyz.sh/)
* [Powerlevel 10k](https://github.com/romkatv/powerlevel10k)

For x86 nodes the following additional packages are installed:
* pv

For DPU nodes the following additional packages are installed:
* [ctop](https://github.com/bcicen/ctop)

The following software is removed:
* NTP (replaced with Chrony)

The following settings are modified:
* Default shell for the `ansible_user` is set to ZSH
* System timezone is set to the value of `chrony_timezone` in `vars/main.yml`
* LLDP settings are modified to advertise correct port names

## Dependencies
* Internet access for Apt and Git


