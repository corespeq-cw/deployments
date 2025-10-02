
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-bridge-detach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-bridge-detach', 'vm-bridge-detach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-bridge-update') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-bridge-update', 'vm-bridge-update');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-vlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-vlan', 'list-vlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'register-vlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('register-vlan', 'register-vlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'deregister-vlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('deregister-vlan', 'deregister-vlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-bridge') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-bridge', 'list-bridge');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'register-bridge') THEN
        INSERT INTO role_action(action, cmd) VALUES ('register-bridge', 'register-bridge');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'deregister-bridge') THEN
        INSERT INTO role_action(action, cmd) VALUES ('deregister-bridge', 'deregister-bridge');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-network-interface') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-network-interface', 'list-network-interface');
    END IF;
END $$;



INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-bridge-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-bridge-update' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-network-interface' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='register-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='deregister-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-bridge' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='register-bridge' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='deregister-bridge' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-bridge-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-bridge-update' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-network-interface' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='register-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='deregister-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-bridge' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='register-bridge' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='deregister-bridge' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-------

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'host-log') THEN
        INSERT INTO role_action(action, cmd) VALUES ('host-log', 'host-log');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='host-log' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='host-log' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='host-log' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
----

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-allowed') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-allowed', 'list-allowed');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-disallowed') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-disallowed', 'list-disallowed');
    END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-allowed' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-disallowed' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-allowed' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-disallowed' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--------
--ALTER TABLE vm_info ADD UNIQUE(name);
ALTER TABLE host_info ADD UNIQUE(host_name);

ALTER TABLE vm_info ADD enable boolean;
UPDATE vm_info SET enable=true WHERE enable IS NULL;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-enable') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-enable', 'vm-enable');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-disable') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-disable', 'vm-disable');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-enable' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-disable' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-enable' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-disable' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-enable' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-disable' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

----

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'unregister-vlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('unregister-vlan', 'unregister-vlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'unregister-vxlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('unregister-vxlan', 'unregister-vxlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'unregister-bridge') THEN
        INSERT INTO role_action(action, cmd) VALUES ('unregister-bridge', 'unregister-bridge');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='unregister-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='unregister-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='unregister-bridge' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='unregister-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='unregister-vlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='unregister-bridge' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


DELETE FROM role_action_grant WHERE action_id in (SELECT ID from role_action WHERE action='deregister-vxlan');
DELETE FROM role_action_grant WHERE action_id in (SELECT ID from role_action WHERE action='deregister-vlan');
DELETE FROM role_action_grant WHERE action_id in (SELECT ID from role_action WHERE action='deregister-bridge');

DELETE FROM role_action WHERE action='deregister-vxlan';
DELETE FROM role_action WHERE action='deregister-vlan';
DELETE FROM role_action WHERE action='deregister-bridge';

