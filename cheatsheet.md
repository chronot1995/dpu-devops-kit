# DPU Cheat Sheet

1. Default Credentials:

- ARM OS: `ubuntu:ubuntu`
- DPU BMC: `root:0penBmc`
- UEFI: `bluefield`

2. Gather DPU Custom Facts from the DevOps Kit

```
ansible-playbook install_custom_facts.yml
ansible dpus -m setup -a 'filter=ansible_local' -b
```

3. Reset the DPU's BMC Password:

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

4.1. Use the microcom Console on the BMC:

```
systemctl stop rshim
systemctl start rshim
microcom /dev/rshim0/console
```

4.2. Exit microcom on the BMC:

Keystroke: "ctrl + x + a"

3.3 Use microcom on the x86:

```
systemctl stop rshim
systemctl start rshim
microcom -p /dev/rshim0/console
```

4.4. Exit microcom on the x86:

Keystroke: "ctrl + \"
"quit" at the prompt

5. View network devices

```
lshw -c network -json
```

6. Show version of DOCA:

cat /etc/mlnx-release
DOCA_1.3.0_BSP_3.9.0_Ubuntu_20.04-6.signed

7. Show version of DPDK:

pkg-config --modversion libdpdk
20.11.4.1.9

8. Type of image via the DPU:

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

8.5 Type of image via the DPU BMC:

```
i2ctransfer -y 7 w2@0x55 0x00 0x02 r5
```

Production Card = 0x40
Development Card = 0x44

9. Reset the DPU from the x86 host:

```
echo "SW_RESET 1" > /dev/rshim0/misc
```

as a sudo user:

```
sudo bash -c "echo "SW_RESET 1" > /dev/rshim0/misc"
```

9.1 Reset the DPU from the BMC:

```
echo "DISPLAY_LEVEL 2" > /dev/rshim0/misc
cat /dev/rshim0/misc
echo 'SW_RESET 1' > /dev/rshim0/misc
```

10. Console connection from the x86 / host:

```
sudo minicom -D /dev/rshim0/console -s
```

10.1 Exit Minicom:

CTRL+Z, A, X

11. Verify Secure Boot:

```
ubuntu@localhost:~$ sudo mokutil --sb-state
SecureBoot enabled
```

12. Serial Number of the DPU:

```
sudo dmidecode -t system | grep Serial
```

13. Serial via Redfish:

```
curl --insecure -u root:password https://<idrac IP>/redfish/v1/Systems/System.Embedded.1/NetworkAdapters/NIC.Slot.5 | jq | grep -i Serial
"SerialNumber": "MT2150#####"
```

14. Docker notes:

```
sudo docker-compose stop
sudo docker exec -it <container name> /bin/bash
sudo docker ps
sudo docker container stats
sudo docker image ls
sudo docker image rm <container ID>
sudo docker stop <container name>
```

Manually copy a file to a Docker container:

```
sudo docker cp cumulusmibs4.3/. librenms:/opt/librenms/mibs/cumulus
```

15. Verify NVUE / YAML config for HBN

```
nv config replace <yamlfile>
```

The above command will output any errors in the .yaml file that prevent it from being loaded as the running configuration in NVUE
