#!/bin/bash

### Variable check
NODES="K8S_MASTER01 K8S_WORKER01 K8S_WORKER02"
COMPONENTS="IP_PREFIX CORES MEMORY STORAGE"
for node in $NODES; do
    for component in $COMPONENTS; do
        VARNAME="${node}_${component}"
	if [[ ! -n ${!VARNAME} ]]; then
            echo "Variable $VARNAME is not defined"
	    exit
	fi
    done
done

if [[ ! -n $ADDITIONAL_DISK_STORAGE ]]; then
    echo "Variable ADDITIONAL_DISK_STORAGE is not defined"
    exit
fi

cat << EOF > k8s-master1.json
{
    "vm_mem"     : "$K8S_MASTER01_MEMORY",
    "vm_core"    : "$K8S_MASTER01_CORES",
    "vm_img_size": "$K8S_MASTER01_STORAGE",
    "os_variant" : "ubuntu24.04",
    "vm_img_type": "local",
    "localpath"  : "/storage/VM/images",
    "fstype"     : "ext4",
    "ipaddr"     : "$K8S_MASTER01_IP_PREFIX",
    "username"   : "k8s-admin",
    "passwd"     : "\$y\$j9T\$sEOrmAk53zVY9ImWz3Vc41\$mK41EWMWYfAhrUjUwb/3gnRH/086obwhph1QWER/Dl1"
}
EOF

cat << EOF > k8s-worker1.json
{
    "vm_mem"     : "$K8S_WORKER01_MEMORY",
    "vm_core"    : "$K8S_WORKER01_CORES",
    "vm_img_size": "$K8S_WORKER01_STORAGE",
    "os_variant" : "ubuntu24.04",
    "vm_img_type": "local",
    "localpath"  : "/storage/VM/images",
    "fstype"     : "ext4",
    "ipaddr"     : "$K8S_WORKER01_IP_PREFIX",
    "username"   : "k8s-admin",
    "passwd"     : "\$y\$j9T\$sEOrmAk53zVY9ImWz3Vc41\$mK41EWMWYfAhrUjUwb/3gnRH/086obwhph1QWER/Dl1"
}
EOF

cat << EOF > k8s-worker2.json
{
    "vm_mem"     : "$K8S_WORKER02_MEMORY",
    "vm_core"    : "$K8S_WORKER02_CORES",
    "vm_img_size": "$K8S_WORKER02_STORAGE",
    "os_variant" : "ubuntu24.04",
    "vm_img_type": "local",
    "localpath"  : "/storage/VM/images",
    "fstype"     : "ext4",
    "ipaddr"     : "$K8S_WORKER02_IP_PREFIX",
    "username"   : "k8s-admin",
    "passwd"     : "\$y\$j9T\$sEOrmAk53zVY9ImWz3Vc41\$mK41EWMWYfAhrUjUwb/3gnRH/086obwhph1QWER/Dl1"
}
EOF

cat << EOF > k8s-worker-data-disk.json
{
    "img_type"   :"local",
    "img_size"   :"$ADDITIONAL_DISK_STORAGE",
    "img_format" :"qcow2",
    "localpath"  :"/storage/VM/images"
}
EOF
