### DPU Cheat Sheet

1. Reset the DPU's BMC Password:

To reset the BMC password, run the following from the DPU:

```
sudo ipmitool raw 0x32 0x66
sudo ipmitool mc reset cold
```

After the card comes back online, ssh into the card with the following credentials

```
ssh root@<BMC IP>
Password: 0penBmc
```

2. View network devices

```
lshw -c network -json
```

3. Show version of DOCA:

cat /etc/mlnx-release
DOCA_1.3.0_BSP_3.9.0_Ubuntu_20.04-6.signed

4. Show version of DPDK:

pkg-config --modversion libdpdk
20.11.4.1.9

5. Type of image:

Signed image = "GA Secured"

```
sudo mlxbf-bootctl
primary: /dev/mmcblk0boot1
backup: /dev/mmcblk0boot0
boot-bus-width: x8
reset to x1 after reboot: FALSE
watchdog-swap: disabled
lifecycle state: GA Secured
secure boot key free slots: 3
```

Development images = "GA Non-Secured" OR "Secured (development)"

```
sudo mlxbf-bootctl
primary: /dev/mmcblk0boot0
backup: /dev/mmcblk0boot1
boot-bus-width: x8
reset to x1 after reboot: FALSE
watchdog-swap: disabled
lifecycle state: Secured (development)
secure boot key free slots: 3
```

6. Reset the DPU from the x86 host:

```
echo "SW_RESET 1" > /dev/rshim0/misc
```

as a sudo user:

```
sudo bash -c "echo "SW_RESET 1" > /dev/rshim0/misc"
```

7. Console connection from the x86 / host:

```
sudo minicom -D /dev/rshim0/console -s
```
