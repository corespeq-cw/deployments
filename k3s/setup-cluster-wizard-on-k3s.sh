#!/bin/bash
set -euo pipefail

show_help() {
  echo "============================================================"
  echo "Cluster Wizard Installer for k3s"
  echo "------------------------------------------------------------"
  echo "This script installs and configures Cluster Wizard and the"
  echo "Wizard Client WebUI on a k3s cluster."
  echo ""
  echo "Usage:"
  echo "  $0 <license-file> [cluster-wizard-ip]"
  echo ""
  echo "Parameters:"
  echo "  <license-file>       Path to your Cluster Wizard license file (e.g., k3s-cw.lic)"
  echo "  [cluster-wizard-ip]  Optional. Node IP where Cluster Wizard will be reachable."
  echo "                       If not provided, the script auto-detects the node IP."
  echo ""
  echo "Examples:"
  echo "  $0 k3s-cw.lic 192.168.5.13"
  echo "  $0 k3s-cw.lic   # auto-detects the node IP"
  echo "============================================================"
}

# No args OR help flags
if [ $# -lt 1 ]; then
  show_help
  exit 1
fi

case "$1" in
  -h|-help|--help)
    show_help
    exit 0
    ;;
esac

LICENSE_FILE="$1"
NAMESPACE="cluster-wizard"
CLIENT_NAMESPACE="wizard-client"
HELM_CHART_VERSION="0.1.0"
WIZARD_CLIENT_HELM_CHART_VERSION="0.1.0"
KUBECONFIG_PATH="/etc/rancher/k3s/k3s.yaml"


#############################################
# Prerequisite Checks
#############################################

# 1. Check if kubectl exists
if ! command -v kubectl &> /dev/null; then
    echo "[ERROR] kubectl is not installed or not in PATH. Is k3s installed?."
    echo "[INFO] k3s can be installed with:"
    echo "  curl -sfL https://get.k3s.io | sh -"
    exit 1
fi
echo "[INFO] kubectl found: $(command -v kubectl)"

KUBECTL_BIN=$(command -v kubectl)
if [ -L "$KUBECTL_BIN" ] && [[ "$(readlink -f "$KUBECTL_BIN")" == *"/k3s" ]]; then
    echo "[INFO] kubectl is provided by k3s ($KUBECTL_BIN -> $(readlink -f "$KUBECTL_BIN"))"
else
    echo "[ERROR] kubectl is not provided by k3s."
    exit 1
fi

# 2. Check if kubeconfig exists
if [ ! -f ${KUBECONFIG_PATH} ]; then
    echo "[ERROR] ${KUBECONFIG_PATH} does not exist. Is k3s installed?"
    echo "[INFO] k3s can be installed with:"
    echo "  curl -sfL https://get.k3s.io | sh -"
    exit 1
fi
echo "[INFO] Found kubeconfig at ${KUBECONFIG_PATH}"

# 3. Check if cluster nodes are accessible and Ready
if ! sudo kubectl get nodes -o wide > /dev/null 2>&1; then
    echo "[ERROR] Unable to contact k3s cluster using kubectl."
    exit 1
fi

# Ensure at least one node is Ready
NODE_STATUS=$(sudo kubectl get nodes --no-headers | awk '{print $2}' | head -n1)
if [ "$NODE_STATUS" != "Ready" ]; then
  echo "[ERROR] Cluster node is not Ready (status: $NODE_STATUS)"
  exit 1
fi

echo "[INFO] k3s cluster is accessible and node is Ready."

# Detect IP if not provided
if [ $# -ge 2 ]; then
  CLUSTER_WIZARD_IP="$2"
else
  echo "[INFO] Auto-detecting Cluster Wizard node IP..."
  CLUSTER_WIZARD_IP=$(sudo kubectl get nodes -o wide | awk 'NR==2{print $6}')
  echo "[INFO] Detected IP: $CLUSTER_WIZARD_IP"
fi



#############################################
# Install Helm
#############################################
echo "[INFO] Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

#############################################
# Install cert-manager
#############################################
echo "[INFO] Installing cert-manager..."
sudo kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.18.2/cert-manager.yaml

echo "[INFO] Waiting for cert-manager pods to become ready..."
sudo kubectl rollout status deployment/cert-manager -n cert-manager --timeout=180s
sudo kubectl rollout status deployment/cert-manager-webhook -n cert-manager --timeout=180s
sudo kubectl rollout status deployment/cert-manager-cainjector -n cert-manager --timeout=180s

#############################################
# Setup Cluster Wizard
#############################################
echo "[INFO] Creating namespace: $NAMESPACE"
sudo kubectl create namespace $NAMESPACE --dry-run=client -o yaml | sudo kubectl apply -f -

echo "[INFO] Creating license secret from $LICENSE_FILE..."
sudo kubectl create secret generic cw-license -n $NAMESPACE \
  --from-file=license="$LICENSE_FILE" --dry-run=client -o yaml | sudo kubectl apply -f -

# --- Certificates & Issuers ---
echo "[INFO] Creating Cluster Wizard Issuer..."
cat <<EOF | sudo kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: cluster-wizard-issuer
  namespace: $NAMESPACE
spec:
  selfSigned: {}
EOF

echo "[INFO] Creating Client CA..."
cat <<EOF | sudo kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: client-ca
  namespace: $NAMESPACE
spec:
  isCA: true
  commonName: CORESPEQ INC
  secretName: client-ca
  privateKey:
    algorithm: RSA
    encoding: PKCS8
    size: 2048
  duration: 87600h
  issuerRef:
    name: cluster-wizard-issuer
    kind: Issuer
EOF

echo "[INFO] Creating Server CA..."
cat <<EOF | sudo kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: server-ca
  namespace: $NAMESPACE
spec:
  isCA: true
  commonName: CORESPEQ INC
  secretName: server-ca
  privateKey:
    algorithm: ECDSA
    size: 521
  duration: 87600h
  issuerRef:
    name: cluster-wizard-issuer
    kind: Issuer
EOF

echo "[INFO] Creating Issuer with Server CA..."
cat <<EOF | sudo kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: issuer-with-server-ca
  namespace: $NAMESPACE
spec:
  ca:
    secretName: server-ca
EOF

echo "[INFO] Creating Cluster Wizard server certificate..."
cat <<EOF | sudo kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: cluster-wizard-cert
  namespace: $NAMESPACE
spec:
  dnsNames:
    - cluster-wizard
  ipAddresses:
    - $CLUSTER_WIZARD_IP
  secretName: cluster-wizard-cert
  issuerRef:
    name: issuer-with-server-ca
    kind: Issuer
  subject:
    organizations:
      - CORESPEQ INC
    organizationalUnits:
      - Cluster Wizard Team
EOF

echo "[INFO] Creating values-override.yaml for Cluster Wizard (NodePort expose)..."
cat <<EOF > values-override.yaml
licenseSecretName: "cw-license"

clusterWizardCert:
  clientCASecretName: "client-ca"
  serverSecretName: "cluster-wizard-cert"

adminUser: "cluster-wizard-admin"
adminEmail: "cluster-wizard-admin@corespeq.com"

postgres:
  install:
    install: true
  password: "supersecret"
  cwPassword: "supersecretToo"

expose:
  type: nodePort
  nodePort:
    ports:
      externalPort:
        port: 50001
        nodePort: 30002
EOF

echo "[INFO] Adding and updating Cluster Wizard Helm repo..."
sudo helm --kubeconfig $KUBECONFIG_PATH repo add cluster-wizard https://charts.cluster-wizard.com/ || true
sudo helm --kubeconfig $KUBECONFIG_PATH repo update

echo "[INFO] Deploying Cluster Wizard via Helm..."
sudo helm --kubeconfig $KUBECONFIG_PATH install cluster-wizard cluster-wizard/cluster-wizard \
  --version $HELM_CHART_VERSION \
  --namespace $NAMESPACE \
  -f values-override.yaml

sudo kubectl rollout status deployment/cluster-wizard -n $NAMESPACE --timeout=300s
echo "[SUCCESS] Cluster Wizard deployed."

#############################################
# Setup Wizard Client WebUI (NodePort)
#############################################
echo "[INFO] Creating namespace for Wizard Client WebUI: $CLIENT_NAMESPACE"
sudo kubectl create namespace $CLIENT_NAMESPACE --dry-run=client -o yaml | sudo kubectl apply -f -

echo "[INFO] Creating client-override.yaml for Wizard Client WebUI (NodePort expose)..."
cat <<EOF > client-override.yaml
configMap:
  backendUrl: "$CLUSTER_WIZARD_IP:30013"
  frontendUrl: "$CLUSTER_WIZARD_IP:30012"

  clusterWizardHost: &clusterWizardHost "cluster-wizard"
  clusterWizardPort: "30002"

etcHost:
  addClusterWizard: true
  clusterWizardIP: "$CLUSTER_WIZARD_IP"
  clusterWizardHost: *clusterWizardHost

clusterWizardCASecretName: "cluster-wizard-server-ca"

expose:
  type: nodePort
  internalTLS:
    enabled: false
  nodePort:
    ports:
      front:
        port: 25080
        nodePort: 30012
      back:
        port: 23051
        nodePort: 30013
EOF

echo "[INFO] Deploying Wizard Client WebUI via Helm..."

sudo kubectl get secret server-ca -n cluster-wizard -o jsonpath='{.data.ca\.crt}' | base64 -d > server-ca.crt
sudo kubectl create secret generic cluster-wizard-server-ca -n wizard-client --from-file=ca.crt=server-ca.crt --dry-run=client -o yaml | sudo kubectl apply -f -

sudo helm --kubeconfig $KUBECONFIG_PATH install wizard-client cluster-wizard/wizard-client-webui \
  --version $WIZARD_CLIENT_HELM_CHART_VERSION \
  --namespace $CLIENT_NAMESPACE \
  -f client-override.yaml

sudo kubectl rollout status deployment/wizard-client-wizard-client-webui -n $CLIENT_NAMESPACE --timeout=300s
echo "[SUCCESS] Wizard Client WebUI deployed."

#############################################
# Create wizard-client-admin-creds Secret
#############################################
echo "[INFO] Creating wizard-client-admin-creds secret in $CLIENT_NAMESPACE..."

sudo kubectl create secret generic wizard-client-admin-creds \
  -n $CLIENT_NAMESPACE \
  --from-literal=cert="$(sudo kubectl get secret admin-cred -n $NAMESPACE -o jsonpath='{.data.cert}' | base64 -d)" \
  --from-literal=private_key="$(sudo kubectl get secret admin-cred -n $NAMESPACE -o jsonpath='{.data.private_key}' | base64 -d)" \
  --from-literal=ca_cert="$(sudo kubectl get secret cluster-wizard-cert -n $NAMESPACE -o jsonpath='{.data.ca\.crt}' | base64 -d)" \
  --dry-run=client -o yaml | sudo kubectl apply -f -

#############################################
# Patch Wizard Client WebUI Deployment to mount the secret
#############################################
echo "[INFO] Patching wizard-client-webui deployment to mount credentials..."
sudo kubectl patch deployment wizard-client-wizard-client-webui -n $CLIENT_NAMESPACE \
  --type='json' \
  -p="[
    {
      \"op\": \"add\",
      \"path\": \"/spec/template/spec/volumes\",
      \"value\": [
        {
          \"name\": \"wizard-client-creds\",
          \"secret\": {
            \"secretName\": \"wizard-client-admin-creds\"
          }
        }
      ]
    },
    {
      \"op\": \"add\",
      \"path\": \"/spec/template/spec/containers/0/volumeMounts\",
      \"value\": [
        {
          \"name\": \"wizard-client-creds\",
          \"mountPath\": \"/app/wizard-client-creds\",
          \"readOnly\": true
        }
      ]
    }
  ]"

sudo kubectl rollout restart deployment wizard-client-wizard-client-webui -n $CLIENT_NAMESPACE
echo "[INFO] Waiting for wizard-client-webui deployment to finish rollout..."
sleep 10
sudo kubectl rollout status deployment/wizard-client-wizard-client-webui -n $CLIENT_NAMESPACE --timeout=300s


#############################################
# Cleanup temporary files
#############################################
rm -f values-override.yaml client-override.yaml server-ca.crt

#############################################
# Summary
#############################################
echo "============================================================"
echo "[SUCCESS] Deployment completed!"
echo ""
echo "Cluster Wizard API:"
echo "  https://$CLUSTER_WIZARD_IP:30002"
echo ""
echo "Wizard Client WebUI:"
echo "  http://$CLUSTER_WIZARD_IP:30012"
echo ""
echo "Admin credentials for Web UI or CLI:"
echo "  sudo kubectl get secret admin-cred -n cluster-wizard -o jsonpath='{.data.private_key}' | base64 -d > admin-private.key"
echo "  sudo kubectl get secret admin-cred -n cluster-wizard -o jsonpath='{.data.cert}' | base64 -d > admin.crt"
echo ""
echo "To exec into the Web UI pod and use wizard-client CLI, run:"
echo "  sudo kubectl exec -it -n wizard-client \$(sudo kubectl get pods -n wizard-client -o jsonpath='{.items[0].metadata.name}') -- /bin/bash "
echo ""
echo "In Web UI pod, wizard-client and admin credentials are provided, run:"
echo "  /app/wizard-client -c hosts -cert /app/wizard-client-creds/cert -ca /app/wizard-client-creds/ca_cert -pkey /app/wizard-client-creds/private_key"
echo ""
echo "============================================================"
