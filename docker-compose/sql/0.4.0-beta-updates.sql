ALTER TABLE host_info
    ADD COLUMN  nw_license    TEXT;

ALTER TABLE role_action ADD UNIQUE(action);

ALTER TABLE cluster_users
    ADD COLUMN  email    varchar(50);

CREATE TABLE IF NOT EXISTS  user_csr_info(
    ID           SERIAL            NOT NULL,
    username     varchar(30)       NOT NULL,
    csr_str      TEXT       ,
    email        varchar(50),
    status       varchar(30),
    reason       varchar(30),
    inserted_ts  timestamp,
    updated_ts   timestamp,
    PRIMARY KEY (ID)
    );

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-sign-csr') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-sign-csr', 'cert-sign-csr');
END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-get-csr') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-get-csr', 'cert-get-csr');
END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-list-csr') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-list-csr', 'cert-list-csr');
END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-sign-csr' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-get-csr' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-list-csr' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;



---- 7/7/2025

ALTER TABLE cluster_users
ADD COLUMN  fullname    varchar(50);


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'host-update') THEN
        INSERT INTO role_action(action, cmd) VALUES ('host-update', 'host-update');
END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'host-renew-lic') THEN
        INSERT INTO role_action(action, cmd) VALUES ('host-renew-lic', 'host-renew-lic');
END IF;
END $$;



INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='host-update' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='host-renew-lic' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


CREATE TABLE IF NOT EXISTS host_deleted(
    ID           SERIAL            NOT NULL,
    host_name    varchar(50)       NOT NULL,
    ip_address   varchar(50),
    host_id      int,
    license_info text,
    deleted_ts   timestamp,
    PRIMARY KEY (ID)
);

---- 7/10/2025
ALTER TABLE host_info
ADD COLUMN  active    VARCHAR(20);

UPDATE host_info SET active = 'active' WHERE COALESCE(active,'') = '';

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'dashboard') THEN
        INSERT INTO role_action(action, cmd) VALUES ('dashboard', 'dashboard');
END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='dashboard' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- 07/15/2025

DELETE FROM role_action_grant WHERE role_id = (SELECT ID from roles WHERE name='user' and type='vm') AND action_id = (SELECT ID from role_action WHERE action='domainxml-save' );
DELETE FROM role_action_grant WHERE role_id = (SELECT ID from roles WHERE name='user' and type='vm') AND action_id = (SELECT ID from role_action WHERE action='domainxml-delete' );

UPDATE role_action SET cmd = 'vm-start' WHERE cmd = 'vmstart';
UPDATE role_action SET cmd = 'vm-shutdown' WHERE cmd = 'vmshutdown';
UPDATE role_action SET cmd = 'vm-destroy' WHERE cmd = 'vmdestroy';
UPDATE role_action SET cmd = 'vm-create' WHERE cmd = 'vmcreate';
UPDATE role_action SET cmd = 'vm-delete' WHERE cmd = 'vmdelete';

-- 7/17/2025
UPDATE user_csr_info SET status = 'requested' WHERE status = 'request';
UPDATE user_csr_info SET status = 'approved' WHERE status = 'approve';
UPDATE user_csr_info SET status = 'rejected' WHERE status = 'reject'; 