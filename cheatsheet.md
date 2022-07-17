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
