# Single Node Basic
In this tutorial, we will install Node Wizard and Node Client on a single host.
Then we create a Ubuntu24 VM using Node Wizard.


## Overview
Explain the purpose of the VM setup - what services/applications will run on it, and why you chose this hosting approach.

## Prerequisites


## Deployment Steps

### 1. Installing packages.
1. Get [the package deployment script](../../node-wizard/scripts/auto_deploy_software.sh), located this the project.
    * Download using wget
    ```wget https://raw.githubusercontent.com/corespeq-cw/deployments/refs/heads/main/node-wizard/scripts/auto_deploy_software.sh```
2. Deploy Node Wizard
    * Install: ```bash auto_deploy_software.sh node-wizard 0.5.0```
    * Check: ```systemctl status node-wizard```
3. Deploy Node Client
    * Install: ```bash auto_deploy_software.sh node-client 0.5.0```
    * Check: ```node-client --version```

### 2. Adding a host and obtaining a license
1. Add the Node Wizard node to Node Client
    * Obtain token: ```sudo /root/bin/node_wizard/node-wizard --token```
    * Add the host: ```node-client -c register-server -S localhost --token [token]```
2. Obtain a Node Wizard license
    * Request licenses: ```node-client -c request-license```
        * TUI or GUI page will be displayed.
        * A license file will be sent via the registered email in the form
    * Add a license: ```node-client -c set-license -f node-wizard.lic```
    * Check license: ```node-client -c list-license```

### 3. Creating a VM
1. Add VM OS iso file(s) to Node Wizard
    * Find ISO files
        * Supported OSes: ```node-client -c iso-list -S localhost```
    * Add them to Node Wizard, e.g.
        * Ubuntu24.04: ```node-client -S localhost -c iso-download -url https://old-releases.ubuntu.com/releases/24.04/ubuntu-24.04.1-live-server-amd64.iso```
        * Ubuntu22.04: ```node-client -S localhost -c iso-download -url https://old-releases.ubuntu.com/releases/22.04/ubuntu-22.04.2-live-server-amd64.iso```
    * Check ISO files: ```node-client -c iso-list -S localhost```
2. Create a VM
    * Write a json configuration file for a VM.
        * Template & example: ```node-client -desc vm-create```
    * Create an Ubuntu24.04 VM
        * Resource: 4 cores, 8G memory, 64G storage (Network: DHCP)
        * Login credentials: admin/changeme
        * Command: ```node-client -S localhost -c vm-create -v vm1 -f ubuntu24-basic.json```

## Configuration

Environment variables, configuration files, and any customization needed.

## Usage

How to start/stop the VM and access the hosted services.

## Troubleshooting

* Repo accessibility
