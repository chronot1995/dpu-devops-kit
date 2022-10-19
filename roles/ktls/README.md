# kTLS Role

This role installs software components to perform a kTLS PoC on either a host or DPU directly. 
  
Only tested with Ubuntu 20.04 host and DPU (DOCA BFB 1.2).  

## Dependencies
* Internet access from DPU and host

## Instructions
**Warning:** This role will build/compile and install OpenSSL 3.0.0 or later on your system. A minimum of OpenSSL 3.0.0 is required for kTLS support. This may have unintended consequences for other services and applications running on the system.

This role is normally meant to be deployed on two devices. A device can be either an x86 host (with a BF2 DPU isntalled) or the DPU itself. The performance tests are performed manually after this role is deployed.  
  
After this role is deployed, a device will be able to:

* Act as an SSL enabled iperf client or server
* Act as a ktls enabled https server (nginx)
* Act as a ktls enabled https client (wrk for testing nginx)

## Running tests

After the playbook runs, there are several tests one can run and then examine performance and kTLS counters

### Relevant kTLS counters

1. `cat /proc/net/tls_stat`
```
$ cat /proc/net/tls_stat
TlsCurrTxSw                             0
TlsCurrRxSw                             0
TlsCurrTxDevice                         0
TlsCurrRxDevice                         0
TlsTxSw                                 2
TlsRxSw                                 2
TlsTxDevice                             7 <<<
TlsRxDevice                             7 <<<
TlsDecryptError                         0
TlsRxDeviceResync                       4
```

2. ethtool stats
```
$ ethtool -S <ifname> | grep -i rx_tls_decrypted
     rx_tls_decrypted_packets: 29510938
     rx_tls_decrypted_bytes: 44384623375

$ ethtool -S <ifname> | grep -i tx_tls_encrypted
     tx_tls_encrypted_packets: 201380947
     tx_tls_encrypted_bytes: 287098201167
```

### Running Iperf Test

iperf is a client/server application, but can test in both directions with the `-d` flag on the client.
1. Designate one DPU/Host to be the iperf server. The other node will be the iperf client.
2. Assign IP addresses to BF2 interfaces. On the DPU, use the SF of p0 or p1 (one of the devices that starts with "enp*")
3. On the iperf server, start iperf: `env LD_LIBRARY_PATH=#LD_LIBRARY_PATH:/tmp/openssl-3.0.0/ /tmp/iperf_ssl/src/iperf  --tls -s -p 5005`
4. On the iperf client, connect to the server: `env LD_LIBRARY_PATH=#LD_LIBRARY_PATH:/tmp/openssl-3.0.0/ ./tmp/iperf_ssl/src/iperf -c <server-ip> -d --tls -p 5005`
5. Compare results with and without the tls_offloads enabled in ethtool:  
```
$ ethtool -K <ifname> tls-hw-tx-offload [on|off]  
$ ethtool -K <ifname> tls-hw-rx-offload [on|off]  
```

### Running nginx Test with wrk
Nginx is already running on both sides. One only needs to run wrk on the client sides
1. `$ taskset -c 0 ./wrk -t1 -c10 -d30s https://x.x.x.x:443/index.html` 
2. Observe results. Test with and without tls_offloads enabled in ethtool:
```
$ ethtool -K <ifname> tls-hw-tx-offload [on|off]  
$ ethtool -K <ifname> tls-hw-rx-offload [on|off]  
```

### nginx file download

The ktls role creates a blank 1gb file for nginx to serve.
1. Visit https://x.x.x.x/testfile
2. Observe counters

## Variables
In vars/main.yml, set the desired OpenSSL Version. A minimum of 3.0.0 is required:
* `openssl_version: "3.0.0"`
  
There are also flags to be able to bypass/skip installation of specific applications. OpenSSL takes ~13-15 mins to compile and nginx takes 30-35 mins. If you wish to skip an application install, toggle the flag in vars/main.yml: 

* `openssl_reinstall_from_source: true`
* `install_iperf_ssl: true`
* `install_wrk: true`
* `install_nginx: true`


