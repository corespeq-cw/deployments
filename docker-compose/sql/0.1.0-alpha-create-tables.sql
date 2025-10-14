\set ON_ERROR_STOP 1

CREATE TABLE IF NOT EXISTS cluster_users (
    ID           int               NOT NULL,
    username     varchar(30)       NOT NULL,
    password     varchar(30),
    is_admin     boolean,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS vm_info (
    ID                 SERIAL               NOT NULL,
    name               varchar(50),
    host_id            int,
    state              varchar(30),
    last_updated_ts    timestamp,
    inserted_ts        timestamp,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS host_info (
    ID           int           NOT NULL,
    host_name    varchar(50),
    ip_address   varchar(50),
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS vm_groups (
    user_id      int           NOT NULL,
    group_name   varchar(50)   NOT NULL,
    PRIMARY KEY (user_id, group_name)
);

CREATE TABLE IF NOT EXISTS vm_group_assignment (
    user_id               int           NOT NULL,
    group_name            varchar(50)   NOT NULL,
    vm_id                 int           NOT NULL,
    PRIMARY KEY (user_id, group_name, vm_id)
);

CREATE TABLE IF NOT EXISTS vm_user_assignment (
    user_id               int           NOT NULL,
    vm_id                 int           NOT NULL,
    PRIMARY KEY (user_id, vm_id)
);

CREATE TABLE IF NOT EXISTS vm_group_user_assignment (
    user_id               int           NOT NULL,
    vm_group_id           int           NOT NULL,
    PRIMARY KEY (user_id, vm_group_id)
);

CREATE TABLE IF NOT EXISTS ceph_images (
    ID                 SERIAL               NOT NULL,
    name               varchar(50),
    last_updated_ts    timestamp,
    inserted_ts        timestamp,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS vm_image_mapping (
    vm_id                 int               NOT NULL,
    image_id              int               NOT NULL,
    last_updated_ts    timestamp,
    PRIMARY KEY (vm_id, image_id)
);

ALTER TABLE vm_info ADD COLUMN IF NOT EXISTS class varchar(50);

ALTER TABLE ceph_images ADD COLUMN IF NOT EXISTS is_deleted boolean;
ALTER TABLE ceph_images ADD COLUMN IF NOT EXISTS image_type varchar(50);

ALTER TABLE vm_image_mapping ADD COLUMN IF NOT EXISTS is_primary boolean;
ALTER TABLE vm_image_mapping ADD COLUMN IF NOT EXISTS is_deleted boolean;

CREATE TABLE IF NOT EXISTS vm_snapshots (
ID  SERIAL  NOT NULL,
snapshot_name varchar(50) NOT NULL,
snapshot_type varchar(50) NOT NULL,
vm_id int NOT NULL,
xml_string  TEXT,
inserted_ts timestamp,
PRIMARY KEY (ID),
UNIQUE(vm_id, snapshot_name)
);

CREATE TABLE IF NOT EXISTS vm_templates (
ID  SERIAL  NOT NULL,
template_name varchar(50) NOT NULL,
template_type varchar(50) NOT NULL,
vm_id int NOT NULL,
xml_string  TEXT,
inserted_ts timestamp,
PRIMARY KEY (ID),
UNIQUE(template_name)
);
