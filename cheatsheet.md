### DPU Cheat Sheet

1. Gather the DPU Custom Facts

```
ansible-playbook install_custom_facts.yml
ansible dpus -m setup -a 'filter=ansible_local' -b
```

2. Reset the DPU's BMC Password:

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

2.1. Use the microcom Console on the BMC:

```
systemctl stop rshim
systemctl start rshim
microcom /dev/rshim0/console
```

2.2. Exit microcom on the BMC:

Keystroke: "ctrl + x + a"

2.3 Use microcom on the x86:

```
systemctl stop rshim
systemctl start rshim
microcom -p /dev/rshim0/console
```

2.4. Exit microcom on the x86:

Keystroke: "ctrl + \"
"quit" at the prompt

3. View network devices

```
lshw -c network -json
```

4. Show version of DOCA:

cat /etc/mlnx-release
DOCA_1.3.0_BSP_3.9.0_Ubuntu_20.04-6.signed

5. Show version of DPDK:

pkg-config --modversion libdpdk
20.11.4.1.9

6. Type of image:

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

7. Reset the DPU from the x86 host:

```
echo "SW_RESET 1" > /dev/rshim0/misc
```

as a sudo user:

```
sudo bash -c "echo "SW_RESET 1" > /dev/rshim0/misc"
```

8. Console connection from the x86 / host:

```
sudo minicom -D /dev/rshim0/console -s
```

8.1 Exit Minicom:

CTRL+Z, A, X

9. Verify Secure Boot:

```
ubuntu@localhost:~$ sudo mokutil --sb-state
SecureBoot enabled
```

10. Serial Number of the DPU:

```
sudo dmidecode -t system | grep Serial
```

11. Git tip

git checkout dmgr2 # gets you "on branch dmgr2"
git fetch origin # gets you up to date with origin
git merge origin/main

12. Serial via Redfish:

```
curl --insecure -u root:password https://<idrac IP>/redfish/v1/Systems/System.Embedded.1/NetworkAdapters/NIC.Slot.5 | jq | grep -i Serial
"SerialNumber": "MT2150#####"
```

13. Docker notes:

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
