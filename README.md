
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache URL Redirection Loops Detected.
---

This incident type relates to the detection of URL redirection loops in Apache web server instances. A URL redirection loop occurs when a client request is redirected to a URL that eventually redirects the client back to the original URL, resulting in an infinite loop. This can cause performance degradation and impact the availability of the web server. Detection of such loops is important to prevent such issues and ensure proper functioning of the web server.

### Parameters
```shell
export VIRTUAL_HOST_NAME="PLACEHOLDER"

export URL="PLACEHOLDER"

export PATH_TO_APACHE_DIRECTORY="PLACEHOLDER"

export PATH_TO_APACHE_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check if Apache is running
```shell
systemctl status apache2
```

### Check Apache error logs
```shell
tail -f /var/log/apache2/error.log
```

### Check Apache access logs
```shell
tail -f /var/log/apache2/access.log
```

### Check Apache configuration for any redirect loops
```shell
apachectl -t -D DUMP_VHOSTS | grep ${VIRTUAL_HOST_NAME}
```

### Check if DNS is resolving correctly
```shell
nslookup ${URL}
```

### Check if the URL is redirecting to the correct location
```shell
curl -I ${URL}
```

### Check the HTTP status code
```shell
curl -s -o /dev/null -w "%{http_code}" ${URL}
```

## Repair

### Implement 301 redirects instead of 302 redirects for permanent URL redirections to prevent loops.
```shell


#!/bin/bash



# Set the variables for the Apache web server root directory and the configuration file

APACHE_DIR=${PATH_TO_APACHE_DIRECTORY}

CONFIG_FILE=${PATH_TO_APACHE_CONFIG_FILE}



# Create a backup of the configuration file before making any changes

cp $CONFIG_FILE $CONFIG_FILE.bak



# Replace all instances of "Redirect 302" with "Redirect 301" in the configuration file

sed -i 's/Redirect 302/Redirect 301/g' $CONFIG_FILE



# Restart the Apache web server to apply the changes

systemctl restart apache2


```