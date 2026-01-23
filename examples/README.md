# Examples of Cluster Wizard and Node Wizard for Building Clusters

## Overview
This directory contains various examples on how to use Cluster/Node Wizard to build clusters.

## List of Directories

1. 01-single-node-basic:
   * On a **single KVM (BM) host**
   * Install Node Wizard/Client(CLI),
   * Add a host and obtain a license
   * Create a Ubuntu 24.04 VM
2. 02-k8s-on-single-host:
   * On two nodes: Node Client on a host and Node Wizard on another node
   * Install Node Client(CLI) on the first host and Node Wizard on a **single KVM (BM) host**
   * Add a host and obtain a license
   * Create three VMs for Kubernetes deployment
       * k8s-master1, k8s-worker1 and k8s-worker2
       * On the **single KVM (BM) host**
