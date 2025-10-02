# 🚀 Cluster Wizard Project

This project provides a containerized environment using **Docker Compose**.  
It includes a PostgreSQL database, an initialization job to populate data, cluster-wizard deployment with certificate generation, and wizard-client-webui.

---

## 📂 Project Structure

```
docker-compose/ 
├── docker-compose.yml 
├── .env.example 
├── cw_files/   # Files required by cluster-wizard 
├── sql/        # SQL files to populate the DB 
├── openssl/    # CA Certificates, Certificates and Keys folder 
└── README.md
```


---

## ⚙️ Services

- **postgres**
    - Runs PostgreSQL
    - Persists data in a Docker volume
    - Healthcheck uses `pg_isready` to ensure readiness

- **db-populator**
    - One‑shot job that seeds the database
    - Runs only after postgres is healthy

- **cluster-wizard**
    - Generates certificates/configs for Cluster-Wizard
    - Runs only after postgres is healthy and db-populator is finished
    - Healthcheck uses `netcat` to ensure Cluster-Wizard is running

- **wizard-client**
    - Wizard-Client / Wizard-Client-WebUI container 
    - Generates certificates and deploys the WebUI with https

---

## 🔑 Environment Variables

Copy `.env.example` to `.env` and adjust values:


```bash
cp .env.example .env
```

```
CW_CEPH_ENABLE=true/false
CW_CEPH_USER=user # Can be empty
CW_CEPH_POOL=pool # Can be empty
EXTERNAL_IP=IP_OF_MY_MACHINE # IP used to access the webui
```

---

## 🧩 Prerequisites

Do not remove files from `cw_files`, `sql` and `openssl` folder.

A license is required to use Cluster-Wizard, you need to store it under `cw_files/cluster-wizard.lic`. 

If you choose to use ceph, `cw_files/ceph.conf` and `cw_files/libvirt.keyring` files are required.
`ceph.conf` need to reference keyring with path `keyring = /cluster_wizard/libvirt.keyring`

---

## ▶️ Usage

### ▶️ Start the stack:
```bash
docker compose up -d
```

Expected output:
```bash
[+] Running 5/5
 ✔ Network compose_default            Created                                                                                                    0.0s
 ✔ Volume "compose_postgres_data"     Created                                                                                                    0.0s
 ✔ Container cluster-wizard-postgres  Healthy                                                                                                   11.3s
 ✔ Container compose-db-populator-1   Exited                                                                                                    11.3s
 ✔ Container cluster-wizard           Healthy                                                                                                   22.0s
 ✔ Container wizard-client-webui      Started                                                                                                   22.2s
```

### 📦 Volumes and certificates

A volume is created for Postgres database files
```bash
docker volume ls
docker volume inspect project_postgres_data
```

CA, certificates and keys are created by `cluster-wizard` service inside `openssl` folder.


### 🛠️ Development Notes

- Use docker compose ps to look at running containers

- Use docker compose logs <service> to follow logs

- Use docker exec -it <container> bash to enter a container


Expected output of ps (to verify that 3 containers are up):
```bash
docker compose ps

NAME                      IMAGE                                          COMMAND                  SERVICE          CREATED              STATUS                        PORTS
cluster-wizard            clusterwizard/cluster-wizard:0.4.0-beta        "/bin/sh -c 'set -e;…"   cluster-wizard   About a minute ago   Up 52 seconds (healthy)       0.0.0.0:50051->50001/tcp, [::]:50051->50001/tcp
cluster-wizard-postgres   postgres:17.5                                  "docker-entrypoint.s…"   postgres         About a minute ago   Up About a minute (healthy)   5432/tcp
wizard-client-webui       clusterwizard/wizard-client-webui:0.4.0-beta   "/bin/sh -c 'set -e;…"   wizard-client    About a minute ago   Up 41 seconds                 0.0.0.0:23051->23051/tcp, [::]:23051->23051/tcp, 0.0.0.0:443->25080/tcp, [::]:443->25080/tcp
```


Expected logs for postgres:
```bash
docker compose logs postgres

...
cluster-wizard-postgres  | 2025-10-02 17:02:32.512 UTC [1] LOG:  starting PostgreSQL 17.5 (Debian 17.5-1.pgdg130+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 14.2.0-19) 14.2.0, 64-bit
cluster-wizard-postgres  | 2025-10-02 17:02:32.512 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
cluster-wizard-postgres  | 2025-10-02 17:02:32.512 UTC [1] LOG:  listening on IPv6 address "::", port 5432
cluster-wizard-postgres  | 2025-10-02 17:02:32.513 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
cluster-wizard-postgres  | 2025-10-02 17:02:32.515 UTC [62] LOG:  database system was shut down at 2025-10-02 17:02:32 UTC
cluster-wizard-postgres  | 2025-10-02 17:02:32.517 UTC [1] LOG:  database system is ready to accept connections
```


Expected logs for db-populator:
```bash
docker compose logs db-populator

...
db-populator-1  | Running /sql/0.4.0-beta-updates.sql
db-populator-1  | ALTER TABLE
db-populator-1  | ALTER TABLE
db-populator-1  | ALTER TABLE
db-populator-1  | CREATE TABLE
db-populator-1  | DO
db-populator-1  | INSERT 0 3
db-populator-1  | ALTER TABLE
db-populator-1  | DO
db-populator-1  | INSERT 0 2
db-populator-1  | CREATE TABLE
db-populator-1  | ALTER TABLE
db-populator-1  | UPDATE 0
db-populator-1  | DO
db-populator-1  | INSERT 0 1
db-populator-1  | DELETE 1
db-populator-1  | DELETE 1
db-populator-1  | UPDATE 1
db-populator-1  | UPDATE 1
db-populator-1  | UPDATE 1
db-populator-1  | UPDATE 1
db-populator-1  | UPDATE 1
db-populator-1  | UPDATE 0
db-populator-1  | UPDATE 0
db-populator-1  | UPDATE 0
```



Expected logs for cluster-wizard:
```bash
docker compose logs cluster-wizard

...
cluster-wizard  | 2025/10/02 17:02:47 START of check license
cluster-wizard  | 2025/10/02 17:02:47 get current time from time server
cluster-wizard  | Signed certificate written to: admin_cert.pem
cluster-wizard  | 2025/10/02 17:02:47 START of check license
cluster-wizard  | 2025/10/02 17:02:47 get current time from time server
cluster-wizard  | 2025/10/02 17:02:47 Starting cluster-wizard ... : 0.4.0-beta
cluster-wizard  | 2025/10/02 17:02:47 CEPH_USER: CEPH_POOL: CEPH_ENABLE:false host:postgres
cluster-wizard  | 2025/10/02 17:02:47 START of check ceph status
cluster-wizard  | 2025/10/02 17:02:47 CEPH disabled
cluster-wizard  | 2025/10/02 17:02:47 Creating ServerKeyPair:
cluster-wizard  | 2025/10/02 17:02:47   loading: /cluster_wizard/server_cert.pem
cluster-wizard  | 2025/10/02 17:02:47   loading: /cluster_wizard/server_key.pem
cluster-wizard  | 2025/10/02 17:02:47 Creating Client Cert Pool
cluster-wizard  | 2025/10/02 17:02:47 loading: /cluster_wizard/client_ca_cert.pem
```

Expected logs for wizard-client:
```bash
docker compose logs wizard-client

...
wizard-client-webui  | .....+.+............+...+..+....+..............+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+...+...+.......+.....+....+...+..................+.....+....+.....+......+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*....+.........+........+...............+...+....+...+...+.........+..+.........+......+......+...................+...+..+....+..+.........+......+.........+......+...+....+...+..+..........+...+...+.....+.......+.....+.........+.............+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
wizard-client-webui  | -----
```



#### 🧠 Test

You can extract admin credentials usings these commands:
```bash
docker compose exec cluster-wizard cat /credentials/admin_cert.pem
docker compose exec cluster-wizard cat /credentials/private.key
```

You can then test that everything is working using wizard-client CLI or WebUI.
To do that, you can:

- Connect to https://EXTERNAL_IP and follow the tutorial here: https://youtu.be/VfopY8jhiQQ?si=aXI0I4WRpvSMIX6v


- Use wizard-client CLI from inside the container.
```bash
docker compose exec -it wizard-client bash

cd app
cat > admin.crt # This is your admin cert from cluster-wizard service 
cat > admin.key # This is your admin cert from cluster-wizard service 
./wizard-client -c get-commands -cert admin.crt -pkey admin.key -ca ../openssl/CA/ca_cert.pem
# Output
{"Commands":["assignment-add","assignment-delete","assignment-host-add","assignment-host-delete","assignments","assignments-host","cert-create-csr","cert-gen-keys","cert-get-csr","cert-info","cert-list-csr","cert-set","cert-sign-csr","dashboard","delete-snap","delete-vminfo","domainxml-delete","domainxml-get","domainxml-list","domainxml-save","dumpxml","dumpxml-snap","get-commands","get-host-env","group-add","group-add-vm","group-delete","group-list","group-remove-vm","groups","help-admin","host-add","host-delete","host-info","host-log","host-renew-lic","hosts","host-update","list","list-allowed","list-bridge","list-disallowed","list-network-interface","list-vlan","list-vxlan","local-snapshots","register-bridge","register-vlan","register-vxlan","rollback","set-host-env","snapshots","snapshots-list","take-local-snap","take-snap","unregister-bridge","unregister-vlan","unregister-vxlan","update-vminfo","update-vminfo-all","user-add","user-delete","users","user-set","version","vm-bridge-attach","vm-bridge-detach","vm-bridge-update","vm-clone","vm-create","vm-delete","vm-destroy","vm-disable","vm-disk-attach","vm-disk-detach","vm-domain-info","vm-enable","vm-hostdev-attach","vm-hostdev-detach","vm-info","vm-list","vm-list-host","vm-migrate","vm-rename","vm-shutdown","vm-start","vm-template","vm-template-dumpxml","vm-template-list","vm-template-local-list","vncdisplay"]}
```


### 🧹 Clean Up

When you are finished working with this project, you may want to remove containers, networks and volumes to free up space on your system.

- Stop services:
  ```bash
  docker compose stop
  
  [+] Stopping 4/4
  ✔ Container wizard-client-webui      Stopped                                                                                                   10.3s
  ✔ Container cluster-wizard           Stopped                                                                                                   10.2s 
  ✔ Container compose-db-populator-1   Stopped                                                                                                    0.0s
  ✔ Container cluster-wizard-postgres  Stopped                                                                                                    0.1s
  ```
  
- Remove containers, networks and volumes:
  ```bash
  docker compose down -v
  
  [+] Running 6/6
  ✔ Container wizard-client-webui      Removed                                                                                                    0.0s
  ✔ Container cluster-wizard           Removed                                                                                                    0.0s
  ✔ Container compose-db-populator-1   Removed                                                                                                    0.0s
  ✔ Container cluster-wizard-postgres  Removed                                                                                                    0.0s
  ✔ Volume compose_postgres_data       Removed                                                                                                    0.0s
  ✔ Network compose_default            Removed                                                                                                    0.2s
  ```

- You can also remove `openssl/CA` and `openssl/server` folders if you plan to deploy a new instance and want new CAs, certificates and keys.
