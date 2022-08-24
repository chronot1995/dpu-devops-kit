# Install Additional Software Role

This installs a number of packages to both x86 and DPU nodes to improve the overall operational experience.

The following packages are installed on both x86 and DPUs:

- [Chrony](https://chrony.tuxfamily.org/)
- [Powerline Fonts](https://github.com/powerline/fonts)
- [ZSH](https://en.wikipedia.org/wiki/Z_shell)
- [Oh My ZSH](https://ohmyz.sh/)
- [Powerlevel 10k](https://github.com/romkatv/powerlevel10k)

The following software is removed:

- NTP (replaced with Chrony)

The following settings are modified:

- Default shell for the `ansible_user` is set to ZSH
- System timezone is set to the value of `chrony_timezone` in `vars/main.yml` or in the `group_vars/all/main.yml` file. The defaults are now in the group vars file, but the entry in the role-specific variable can be used to override the group_vars.

## Dependencies

- Internet access for Apt and Git
