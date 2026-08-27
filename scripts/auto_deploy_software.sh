#!/bin/bash

set -e 

help() {
  echo "Usage: $0 <node-client|wizard-client|node-wizard> [version] [-s]"
  echo "            -s is to skip checking dependencies and installing packages (only for node-client/node-wizard version >= 0.5.1)"
}

if [ $# -lt 1 ]; then
  help
  exit 1
fi

case "$1" in
    -h)
        help
        exit 0
        ;;
    *)
        PROJECT=$1
        shift
        ;;
esac

PROJECT_VERSION=""
S_OPTION=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -s)
            S_OPTION=true
            ;;
        -*)
            echo "Unknown Option"
            exit 2
            ;;
        *)
            if [[ -z "$PROJECT_VERSION" ]]; then
                PROJECT_VERSION="$1"
            else
                echo "Unexpected argument: $1"
                exit 1
            fi
            ;;
    esac
    shift
done

case "$PROJECT" in
    node-client)
        ;;
    wizard-client)
        if [[ "$S_OPTION" == true ]]; then
              echo "-s is not compatible with wizard-client"
              exit 1
        fi
        ;;
    node-wizard)
        ;;
    *)
        echo "Unknown software"
        exit 2
        ;;
esac


OS=$(uname -s)
ARCH=$(uname -m)
DOWNLOAD=""

if [ "$OS" = "Darwin" ]; then
    if [ "$PROJECT" != "node-wizard" ]; then
        case "$ARCH" in
            arm64)  DOWNLOAD="mac-arm64" ;;
            x86_64) DOWNLOAD="mac-amd64" ;;
            *) echo "Unsupported mac architecture: $ARCH"; exit 1 ;;
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
                26.*) DOWNLOAD="ubuntu26" ;;
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

if [ -z "$PROJECT_VERSION" ]; then
  if [ "$PROJECT" = "node-wizard" ]; then
    PROJECT_VERSION="0.6.0"
  elif [ "$PROJECT" = "node-client" ]; then
    PROJECT_VERSION="0.6.0"
  else
    PROJECT_VERSION="0.6.0"
  fi
fi


echo "You are going to download $PROJECT $PROJECT_VERSION for $DOWNLOAD"
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
if [ "$PROJECT" != "node-wizard" ]; then
  file="https://download.cluster-wizard.com/client-license"
else
  file="https://download.cluster-wizard.com/node-wizard-license"
fi

curl -s $file


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

curl -f "https://download.cluster-wizard.com/files/$PROJECT/$PROJECT_VERSION/$PROJECT-$PROJECT_VERSION-$DOWNLOAD.tgz" -s -o "/tmp/$PROJECT.tgz" || { echo "Package not found, please verify version and os"; exit 4; }

if [ "$PROJECT" = "wizard-client" ]; then
  tar -xf "/tmp/$PROJECT.tgz" -C /tmp
  sudo mkdir -p /usr/local/bin
  sudo cp /tmp/wizard-client /usr/local/bin/
else
  extracted_dir=$(tar -tf "/tmp/$PROJECT.tgz" | head -1 | cut -d/ -f1)
  tar -xf "/tmp/$PROJECT.tgz" -C /tmp

  cd /tmp/$extracted_dir
  if [[ $DOWNLOAD == *mac* ]]; then
    sudo mkdir -p /usr/local/bin
    sudo cp node-* /usr/local/bin/
  else
    if [[ "$S_OPTION" == true ]]; then
        sudo ./deploy-*.sh -ds
    else
        sudo ./deploy-*.sh -d
    fi
  fi
fi