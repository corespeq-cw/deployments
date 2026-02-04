\set ON_ERROR_STOP 1

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='hosts' )    ),
    (  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='vm-template-list' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='hosts' )    ),
    (  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='vm-template-list' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--- 08/19/2025
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cluster-env') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cluster-env', 'cluster-env');
END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cluster-env' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


--- 09/15/2025
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'iso-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('iso-list', 'iso-list');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'iso-download') THEN
        INSERT INTO role_action(action, cmd) VALUES ('iso-download', 'iso-download');
END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='iso-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='iso-download' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--- 09/22/2025
INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='iso-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='iso-download' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- 9/23/2025 add new role cluster/audit
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM roles WHERE name = 'audit' AND type = 'cluster') THEN
        INSERT INTO roles(name, type) VALUES ('audit', 'cluster');
END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='assignments' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='assignments-host' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='cert-list-csr' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='cluster-env' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='dashboard' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='domainxml-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='dumpxml' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='dumpxml-snap' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='get-commands' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='get-host-env' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='group-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='groups' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='help-admin' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='systeminfo' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='host-log' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='hosts' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='iso-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-allowed' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-bridge' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-disallowed' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-network-interface' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-vlan' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='list-vxlan' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='local-snapshots' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='snap-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='snap-list-all' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='users' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='version' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-domain-info' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-info' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-dumpxml' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-list' )   ),
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-local-list' )   )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- 10/12/2025

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-vm-start') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-vm-start', 'admin-vm-start');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-vm-shutdown') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-vm-shutdown', 'admin-vm-shutdown');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-vm-destroy') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-vm-destroy', 'admin-vm-destroy');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-take-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-take-snap', 'admin-take-snap');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-take-local-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-take-local-snap', 'admin-take-local-snap');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-delete-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-delete-snap', 'admin-delete-snap');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'admin-rollback') THEN
        INSERT INTO role_action(action, cmd) VALUES ('admin-rollback', 'admin-rollback');
END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-vm-start' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-vm-shutdown' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-vm-destroy' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-take-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-take-local-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-delete-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='admin-rollback' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- 10/15/2025

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'vm_info'
          AND column_name = 'name'
    ) THEN
ALTER TABLE vm_info ALTER COLUMN name TYPE varchar(59);
END IF;
END$$;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'ceph_images'
          AND column_name = 'name'
    ) THEN
ALTER TABLE ceph_images ALTER COLUMN name TYPE varchar;
END IF;
END$$;

DO $$
BEGIN
   IF EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'cluster_users'
        AND column_name = 'password'
   ) AND EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'cluster_users'
        AND column_name = 'email'
   ) AND EXISTS (
      SELECT 1 FROM information_schema.columns
      WHERE table_name = 'cluster_users'
        AND column_name = 'fullname'
   ) THEN
ALTER TABLE cluster_users
ALTER COLUMN password TYPE text,
         ALTER COLUMN email TYPE varchar(254),
         ALTER COLUMN fullname TYPE varchar(100);
END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'user_csr_info'
          AND column_name = 'email'
    ) THEN
ALTER TABLE user_csr_info ALTER COLUMN email TYPE varchar(254);
END IF;
END$$;

-- 10/20/2025
ALTER TABLE cluster_users ADD COLUMN IF NOT EXISTS enable_password boolean;

UPDATE cluster_users SET enable_password = true WHERE enable_password is null;

-- new command
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'passwd') THEN
        INSERT INTO role_action(action, cmd) VALUES ('passwd', 'passwd');
END IF;
END $$;



INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='passwd' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='passwd' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='passwd' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='passwd' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


-- 10/22/2025
CREATE TABLE IF NOT EXISTS cluster_config (
                                              ubuntu_repo  varchar(150),
    last_updated_ts timestamp
    );

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cluster-config-set') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cluster-config-set', 'cluster-config-set');
END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cluster-config') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cluster-config', 'cluster-config');
END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cluster-config-set' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cluster-config' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


SET vars.cw_admin_user = :'CW_ADMIN_USER';
SET vars.cw_admin_password = :'CW_ADMIN_PASSWORD';

UPDATE cluster_users SET password = current_setting('vars.cw_admin_password')::text WHERE username = current_setting('vars.cw_admin_user')::text AND (password IS NULL OR password = '');




-- 12/08/2025 cluster/audit missing auth


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='passwd' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='audit' and type='cluster'), (SELECT ID from role_action WHERE action='cluster-config' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
