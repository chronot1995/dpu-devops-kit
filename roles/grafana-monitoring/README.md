# dpu-poc-grafana-monitoring

### Description

This is a simple Ansible Playbook that will output DPU statistics into Grafana's Loki cloud:

This playbook is described in detail on Galaxy at the following location:

https://galaxy.ansible.com/nleiva/grafana_agent

### Instructions:

1. First, add the Ansible Galaxy role by either entering the following:

```
ansible-galaxy collection install community.general
ansible-galaxy install nleiva.grafana_agent
```

or the following:

```
ansible-galaxy install -r roles/grafana-monitoring/requirements.yml
```

2. Next, you will need to sign up for an account with Grafana the following location:

https://grafana.com/auth/sign-up/create-user

3. Next, you will need to edit the following in the "group_vars > all.yml" file:

"dpu_loki_user" -> In Grafana Cloud, go to the "gear" / Configuration > Data Sources > "The Loki instance" > Basic Auth Details > "User"

"dpu_prometheus_user" -> In Grafana Cloud, go to the "gear" / Configuration > Data Sources > "The Prometheus instance" > Basic Auth Details > "User"

"dpu_grafana_api_key" -> Log into Grafana.com, not the <org>.grafana.com instance which shows the dashboards. On the left side, go to Security > API Keys > and "+Add API Key" > give it the "MetricsPublisher" role

4. Run the Ansible playbook with the following command:

```
ansible-playbook poc-grafana.yml
```

Output:

```
mcourtney@ubuntu:~/dpugrafana$ ansible-playbook poc-grafana.yml

PLAY [bfs] *****************************************************************************************

TASK [Gathering Facts] *****************************************************************************
Friday 01 October 2021  23:48:40 -0500 (0:00:00.013)       0:00:00.013 ********
ok: [bfipsec1]

TASK [nleiva.grafana_agent : Download Agent file] **************************************************
Friday 01 October 2021  23:48:44 -0500 (0:00:03.508)       0:00:03.522 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Install unzip] ********************************************************
Friday 01 October 2021  23:48:47 -0500 (0:00:03.238)       0:00:06.760 ********
[WARNING]: Updating cache and auto-installing missing dependency: python-apt
ok: [bfipsec1]

TASK [nleiva.grafana_agent : Unarchive Agent] ******************************************************
Friday 01 October 2021  23:49:21 -0500 (0:00:34.539)       0:00:41.300 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Create directory for Agent's config file] *****************************
Friday 01 October 2021  23:49:26 -0500 (0:00:04.128)       0:00:45.428 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Create Agent's config file] *******************************************
Friday 01 October 2021  23:49:27 -0500 (0:00:01.477)       0:00:46.905 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Template the new service file for Grafana agent] **********************
Friday 01 October 2021  23:49:29 -0500 (0:00:01.741)       0:00:48.647 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Reload and start service Grafana agent] *******************************
Friday 01 October 2021  23:49:31 -0500 (0:00:01.741)       0:00:50.388 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Install Promtail] *****************************************************
Friday 01 October 2021  23:49:33 -0500 (0:00:02.661)       0:00:53.050 ********
included: /home/mcourtney/.ansible/roles/nleiva.grafana_agent/tasks/promtail.yml for bfipsec1

TASK [nleiva.grafana_agent : Download latest Promtail release] *************************************
Friday 01 October 2021  23:49:33 -0500 (0:00:00.046)       0:00:53.096 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Create directory for Promtail's files] ********************************
Friday 01 October 2021  23:49:36 -0500 (0:00:02.529)       0:00:55.625 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Unarchive Promtail] ***************************************************
Friday 01 October 2021  23:49:37 -0500 (0:00:01.393)       0:00:57.019 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Create an Promtail config file] ***************************************
Friday 01 October 2021  23:49:40 -0500 (0:00:02.428)       0:00:59.447 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Template the new service file for Promtail agent] *********************
Friday 01 October 2021  23:49:41 -0500 (0:00:01.659)       0:01:01.107 ********
changed: [bfipsec1]

TASK [nleiva.grafana_agent : Reload and start service Promtail agent] ******************************
Friday 01 October 2021  23:49:43 -0500 (0:00:01.703)       0:01:02.810 ********
changed: [bfipsec1]

PLAY RECAP *****************************************************************************************
bfipsec1                   : ok=15   changed=12   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

Friday 01 October 2021  23:50:16 -0500 (0:00:33.299)       0:01:36.110 ********
===============================================================================
nleiva.grafana_agent : Install unzip ------------------------------------------------------- 34.54s
nleiva.grafana_agent : Reload and start service Promtail agent ----------------------------- 33.30s
nleiva.grafana_agent : Unarchive Agent ------------------------------------------------------ 4.13s
Gathering Facts ----------------------------------------------------------------------------- 3.51s
nleiva.grafana_agent : Download Agent file -------------------------------------------------- 3.24s
nleiva.grafana_agent : Reload and start service Grafana agent ------------------------------- 2.66s
nleiva.grafana_agent : Download latest Promtail release ------------------------------------- 2.53s
nleiva.grafana_agent : Unarchive Promtail --------------------------------------------------- 2.43s
nleiva.grafana_agent : Template the new service file for Grafana agent ---------------------- 1.74s
nleiva.grafana_agent : Create Agent's config file ------------------------------------------- 1.74s
nleiva.grafana_agent : Template the new service file for Promtail agent --------------------- 1.70s
nleiva.grafana_agent : Create an Promtail config file --------------------------------------- 1.66s
nleiva.grafana_agent : Create directory for Agent's config file ----------------------------- 1.48s
nleiva.grafana_agent : Create directory for Promtail's files -------------------------------- 1.39s
nleiva.grafana_agent : Install Promtail ----------------------------------------------------- 0.05s
```

### Viewing Log Data in Grafana Cloud:

1. Click the "Explore" button > in the top drop down select the Loki / "logs" instance

2. Click the "Log browser" button, which should be blue, click the IP address of the "hostname" > click the "Show logs" button.

3. From here, you should see log information in the bottom pane.

### Prometheus Graph Data in Grafana Cloud:

1. Click the "Explore" button > in the top drop down select the Prometheus / "prom" instance

2. Click the "Metrics browser" button, which should be blue, to see what data is being sent from the DPU to Grafana Cloud.

3. To put together a testing dashboard, click the Dashboards > Manage > "Import" button in the top right-hand corner.

For this demo, use the following Dashboard:

https://grafana.com/grafana/dashboards/10180

4. Here, enter "10180" in the "Import via grafana.com" and click the "Load" button

5. Next, click Dashboards > Manage > General > "Linux Hosts Metrics"

This will load the above Dashboard with the data for the DPU

### Extras

1. Promtail is the log aggregator that sends data to the Grafana Cloud. The default configuration file is found at:

```
/opt/promtail/promtail-config.yaml
```

The default log setting has the following configuration:

```
__path__: /var/log/*.log
```

In order to gather more data from the box, it might be worthwhile to change this to the following:

```
__path__: /var/log/*log
```

The above will now grab and send data from the "syslog" file under /var/log up to Grafana Cloud

After you change the above, you will need to run the following to restart the Promtail service:

```
sudo systemctl stop promtail.service
sudo systemctl daemon-reload
sudo systemctl start promtail.service
sudo systemctl status promtail.service
```
