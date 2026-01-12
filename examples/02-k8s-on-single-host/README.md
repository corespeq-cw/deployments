# Kubernetes Cluster on a Single Host

## Overview: Creating a set of three VMs for Kubernetes deployment
* Unlike the previous example 01-single-node-basic, Node Client will be installed on a different node than the node for Node Wizard.
* We will create three VMs with static IP addresses
   1. k8s-master1
   2. k8s-worker1
   3. k8s-worker2

## Prerequisites
* To have VMs with decent resources, we expect a AMD64 architecture node with the following hardware resource
   * 20+ HT cores
   * 40+ GiB memory
   * 1TiB disk storage
*  Linux OSes
   * Ubuntu 24.04, Ubuntu 22.04 and Ubuntu 20.04
   * RedHat Enterprise Linux 9
   * Rockey Linux 9
   * SLES 15
* Packages
   * jq : lightweight and flexible command-line JSON processor
* Network Resource
   * A Network bridge with Internet connection

## Deployment Steps
### 1. Installing packages.
1. Get [the package deployment script](../../node-wizard/scripts/auto_deploy_software.sh), located this the project.
   * Download using wget
      * ```wget https://raw.githubusercontent.com/corespeq-cw/deployments/refs/heads/main/node-wizard/scripts/auto_deploy_software.sh```
2. Deploy Node Wizard
   * Install
      * ```bash auto_deploy_software.sh node-wizard 0.5.0```
   * Check
      * ```systemctl status node-wizard```
3. Deploy Node Client
   * Install
      * ```bash auto_deploy_software.sh node-client 0.5.0```
   * Check
      *  ```node-client --version```

### 2. Configuring Environmental Variables
1. Copy set_env.sh.example to set_env.sh
2. Edit set_sen.sh for updating these variables if necessary
    * KVM_HOST_IP: no default (e.g. 192.168.1.100)
    * K8S_MASTER01_IP_PREFIX : no default (e.g. 192.168.1.101/24)
    * K8S_WORKER01_IP_PREFIX : no default (e.g. 192.168.1.102/24)
    * K8S_WORKER02_IP_PREFIX : no default (e.g. 192.168.1.103/24)
    * K8S_MASTER01_CORES: 4
    * K8S_WORKER01_CORES: 6
    * K8S_WORKER02_CORES: 6
    * K8S_MASTER01_MEMORY: 8
    * K8S_WORKER01_MEMORY: 12
    * K8S_WORKER02_MEMORY: 12
    * K8S_MASTER01_STORAGE: 128
    * K8S_WORKER01_STORAGE: 128
    * K8S_WORKER02_STORAGE: 128
    * ADDITIONAL_DISK_STORAGE: 128
3. Source set_env.sh
    * ```source set_env.sh```
4. Generate configuration files for VM creation
    * ```bash generate-config.sh```
    * Four files will be generated
       * k8s-master1.json
       * k8s-worker1.json
       * k8s-worker2.json
       * k8s-worker-data-disk.json

### 3. Adding a host and obtaining a license 
1. Add the Node Wizard node to Node Client
   * Obtain token on KVM_HOST
      * ```sudo /root/bin/node_wizard/node-wizard --token```
   * Add the host (on the Node Client node)
      * ```node-client -c register-server -S $KVM_HOST_IP --token [token]```
2. Obtain a Node Wizard license (on the Node Client node)
   * Request licenses
      * ```node-client -c request-license```
      * TUI or GUI page will be displayed.
      * A license file will be sent via the registered email in the form
   * Add a license
      * ```node-client -c set-license -f node-wizard.lic```
   * Check license
      * ```node-client -c list-license```

### 4. Create VMs
1. Add VM OS iso file(s) to Node Wizard
    * Find ISO files
        * Supported OSes
            * ```node-client -c iso-list -S $KVM_HOST_IP```
    * Add them to Node Wizard, e.g.
        * Ubuntu24.04:
            * ```node-client -S $KVM_HOST_IP -c iso-download -url https://old-releases.ubuntu.com/releases/24.04/ubuntu-24.04.1-live-server-amd64.iso```
        * Ubuntu22.04:
            * ```node-client -S $KVM_HOST_IP -c iso-download -url https://old-releases.ubuntu.com/releases/22.04/ubuntu-22.04.2-live-server-amd64.iso```
    * Check ISO files:
        * ```node-client -c iso-list -S $KVM_HOST_IP```
2. Create three VMs
   * Run vm-create commands
      ```bash
      node-client -S $KVM_HOST_IP -c vm-create -v k8s-master1 -f k8s-master1.json
      node-client -S $KVM_HOST_IP -c vm-create -v k8s-worker1 -f k8s-worker1.json
      node-client -S $KVM_HOST_IP -c vm-create -v k8s-worker2 -f k8s-worker2.json
      ```
   * Check status of VM creation
      * VM states using Node Client
         * ```node-client -S $KVM_HOST_IP -c list```
      * VNC connection using a VNC client
         * Obtain VNC information (Port and Password)
            ```bash
            node-client -S $KVM_HOST_IP -c vncdisplay -v k8s-master1
            node-client -S $KVM_HOST_IP -c vncdisplay -v k8s-worker1
            node-client -S $KVM_HOST_IP -c vncdisplay -v k8s-worker2
            ```
        * Connect $KVM_HOST_IP:port with Password
2. Add an additional disk to k8s-worker1 and k8s-worker2
   * Once the VMs are in shutdown state, add an additional disk to the two worker VMs
   ```bash
   node-client -S $KVM_HOST_IP -c vm-disk-attach -v k8s-worker1 -target vdb -f k8s-worker-data-disk.json
   node-client -S $KVM_HOST_IP -c vm-disk-attach -v k8s-worker2 -target vdb -f k8s-worker-data-disk.json
   ```
3. Start all the VMs
   1. Start all the VMs using Node Client
   ```bash
   node-client -S $KVM_HOST_IP -c vm-start -v k8s-master1
   node-client -S $KVM_HOST_IP -c vm-start -v k8s-worker1
   node-client -S $KVM_HOST_IP -c vm-start -v k8s-worker2
   ```
   2. Check disks using Node Client. Please note that the disk information is available from guest agent while the VMs are running
   ```bash
   node-client -S $KVM_HOST_IP -c vm-domain-info -v k8s-worker1 -key disk
   node-client -S $KVM_HOST_IP -c vm-domain-info -v k8s-worker2 -key disk
   ```

## Usage
As the overview is indicated, this VM configuration is intended for deploying a small Kubernetes cluster.
* The number of VMs can be easily modified for different sizes of Kubernetes
* Additonial disks are used for storage provisioners like Longhorn
   * The intended deployment is described in [Longhorn: Kubernetes native block storage](https://blog.devgenius.io/longhorn-kubernetes-native-block-storage-d879bb2735a9)
* With VM snapshot/rollback capabilities, Kubernetes can easily re-deployed

Node Wizard enables a life-cycle management of VMs.
* Create/Delete VMs
* Start/Shutdown/Destory VMs
* Attach/Detach bridges/disks/PCI devices
* Take snapshots and rollback to snapshots
* For the full list of features, run the help command
   * ```node-client -h```

## Troubleshooting
* For Ubuntu VMs, we need Ubuntu repository to install qemu-guest packages. We have a few occations the the official repo timed out. You may delete the VM and recreate it.
* If auto-installation fails, you may use VNC access to debug.

