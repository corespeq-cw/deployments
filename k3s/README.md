# Cluster Wizard Project 
## Cluster Wizard Installer for k3s

This repository provides a Bash script to install and configure [**Cluster Wizard**](https://cluster-wizard.com/) along with the **Wizard Client Web UI** on a [k3s](https://k3s.io/) Kubernetes cluster.

The script automates:
 - Installation of **Helm** and **cert-manager**
 - Creation of required **certificates** and **issuers** using cert-manager
 - Deployment of **Cluster Wizard** with NodePort exposure
 - Deployment of **Wizard Client Web UI** with NodePort exposure
 - Mounting of admin certificates and keys into the Web UI pod for use with the `wizard-client` CLI

## 📋 Prerequisites
 - A running **k3s cluster**
 - Access to the cluster with kubectl
 - A valid **Cluster Wizard** license file (e.g., k3s-cw.lic)
 - bash and sudo available on the host

## 🚀 Usage
Run the script:
```
curl -sfL https://raw.githubusercontent.com/corespeq-cw/deployments/refs/heads/main/k3s/setup-cluster-wizard-on-k3s.sh | bash -s -- <license-file>
```
or
```
git clone https://github.com/corespeq-cw/deployments.git
cd deployments/k3s
./setup-cluster-wizard-on-k3s.sh <license-file>
```

### Parameters
 - `<license-file>` - Path to your Cluster Wizard license file (**required**).
 - `[cluster-wizard-ip]` – Node IP where Cluster Wizard will be reachable (**optional**).
   - If omitted, the script will auto-detect the node IP from the cluster.

## 🚀 Install Example
```
#Install k3s
curl -sfL https://get.k3s.io | sh -

#Install Cluster Wizard and Wizard Client Web UI on K3s
curl -sfL https://raw.githubusercontent.com/corespeq-cw/deployments/refs/heads/main/k3s/setup-cluster-wizard-on-k3s.sh | bash -s -- k3s-cw.lic

```
See [Cluster Wizard Deployment](https://cluster-wizard.com/docs/installation/cluster-wizard-deployment#verifying-installation) for verification steps.

Problems? See [Cluster Wizard Troubleshooting](https://cluster-wizard.com/docs/installation/cluster-wizard-deployment#troubleshooting) for troubleshooting steps.

## Accessing Cluster Wizard
After successful deployment, you can reach:
 - **Cluster Wizard** API: `https://<node-ip>:30002`
 - **Wizard Client Web UI** : `http://<node-ip>:30012`

Admin credentials for Web UI can be obtained by running:
```
sudo kubectl get secret admin-cred -n cluster-wizard -o jsonpath='{.data.private_key}' | base64 -d > admin-private.key
sudo kubectl get secret admin-cred -n cluster-wizard -o jsonpath='{.data.cert}' | base64 -d > admin.crt
```

### Using wizard-client CLI inside the Web UI pod
To exec into the Web UI pod:
```
sudo kubectl exec -it -n wizard-client $(sudo kubectl get pods -n wizard-client -o jsonpath='{.items[0].metadata.name}') -- /bin/bash
```

Once inside, run wizard-client with provided admin credentials:
```
/app/wizard-client \
  -c hosts \
  -cert /app/wizard-client-creds/cert \
  -ca /app/wizard-client-creds/ca_cert \
  -pkey /app/wizard-client-creds/private_key
```



