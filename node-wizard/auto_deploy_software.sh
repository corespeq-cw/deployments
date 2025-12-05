#!/bin/bash

set -e 

if [ $# -lt 1 ]; then
    echo "Usage: $0 <node-client|node-wizard> [version]"
    exit 1
fi

case "$1" in
    node-client)
        ;;
    node-wizard)
        ;;
    *)
        echo "Unknow software"
        exit 2
        ;;
esac


OS=$(uname -s)
ARCH=$(uname -m)
DOWNLOAD=""

if [ "$OS" = "Darwin" ]; then
    if [ "$1" != "node-wizard" ]; then
        case "$ARCH" in
            arm64)  DOWNLOAD="macOS-arm64" ;;
            x86_64) DOWNLOAD="macOS-amd64" ;;
            *) echo "Unsupported macOS architecture: $ARCH"; exit 1 ;;
        esac
    else
        echo "Darwin is only supported when software is client"
        exit 1
    fi
elif [ "$OS" = "Linux" ]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" = "ubuntu" ]; then
            case "$VERSION_ID" in
                20.*) DOWNLOAD="ubuntu20" ;;
                22.*) DOWNLOAD="ubuntu22" ;;
                24.*) DOWNLOAD="ubuntu24" ;;
                *) echo "Unsupported Ubuntu version: $VERSION_ID"; exit 1 ;;
            esac
        elif [ "$ID" = "rocky" ] && [[ "$VERSION_ID" =~ ^9 ]]; then
            DOWNLOAD="rocky9"
        elif [ "$ID" = "rhel" ] && [[ "$VERSION_ID" =~ ^9 ]]; then
            DOWNLOAD="rhel9"
        elif [ "$ID" = "sles" ] && [[ "$VERSION_ID" =~ ^15 ]]; then
            DOWNLOAD="sles15"
        else
            echo "Unsupported Linux distribution/version: $ID $VERSION_ID"
            exit 1
        fi
    else
        echo "/etc/os-release not found"
        exit 1
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

if [ $# -ge 2 ]; then
    VERSION=$2
else
    VERSION="latest"
fi


echo "You are going to download $1 $VERSION for $DOWNLOAD" 
echo "Do you want to continue? (y/n)"
read -r answer

if [[ $answer == "y" || $answer == "Y" ]]; then
    echo "Confirmed, continuing..."
    echo ""
    echo ""
else
    echo "Cancelled."
    exit 3
fi


file=""
if [ "$1" != "node-wizard" ]; then
  file="https://gitlab.com/cluster-wizard/release/-/wikis/License/Node-Wizard/AUTHORIZED-CLIENT-USER-TERMS-OF-USE-(CLIENT)"
else
  file="https://gitlab.com/cluster-wizard/release/-/wikis/License/Node-Wizard/Software-License-Agreement"
fi

if [[ $DOWNLOAD == *mac* ]]; then
  curl -s $file | grep -oE 'content&quot;:&quot;[^"]*?&quot;,' | sed 's/^content&quot;:&quot;//; s/&quot;,$//' | sed 's/\\r\\n/\n/g; s/\\"/"/g; s/&quot;/"/g; s/&#39;/'"'"'/g; s/\\u0026emsp;/ /g' | sed 's/\\"/"/g;' 
else
  curl -s $file | grep -Po 'content&quot;:&quot;\K.*?(?=&quot;,)' -o   | sed 's/\\r\\n/\n/g; s/\\"/"/g; s/&quot;/"/g; s/&#39;/'"'"'/g; s/\\u0026emsp;/ /g' | sed 's/\\"/"/g;' 

fi

echo "Do you accept the license? (y/n)"
read -r answer
if [[ $answer == "y" || $answer == "Y" ]]; then
    echo "Confirmed, continuing..."
    echo ""
    echo ""
else
    echo "Cancelled."
    exit 3
fi

URL="https://cluster-wizard.gitlab.io/release/download/node/latest"

HTML=$(curl -s "$URL")

JSFILE=$(echo "$HTML" | grep -o 'src="[^"]*index[^"]*\.js"' | cut -d'"' -f2)

BASE="https://cluster-wizard.gitlab.io"
JSURL=$(echo "$BASE/$JSFILE")


DOWNLOADJS=$(curl -s "$JSURL" | grep -oE 'Download-[^"]+\.js' | head -n1)

TOKEN=$(curl -s https://cluster-wizard.gitlab.io/release/assets/$DOWNLOADJS | grep -oE 'glpat-[^"]*')

curl -f -H "PRIVATE-TOKEN: $TOKEN" "https://gitlab.com/api/v4/projects/57050576/packages/generic/$1/$VERSION/$1-$VERSION-$DOWNLOAD.tgz" -s -o "/tmp/$1.tgz" || { echo "Package not found, please verify version and os"; exit 4; }

extracted_dir=$(tar -tf "/tmp/$1.tgz" | head -1 | cut -d/ -f1)
tar -xf "/tmp/$1.tgz" -C /tmp

cd /tmp/$extracted_dir
if [[ $DOWNLOAD == *mac* ]]; then
  sudo mkdir -p /usr/local/bin
  sudo cp node-* /usr/local/bin/
else
  sudo ./deploy-*.sh -d
fi

