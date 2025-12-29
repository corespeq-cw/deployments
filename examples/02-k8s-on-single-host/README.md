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


