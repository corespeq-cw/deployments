\set ON_ERROR_STOP 1

-- insert cert commands

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-gen-keys') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-gen-keys', 'cert-gen-keys');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-create-csr') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-create-csr', 'cert-create-csr');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-set') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-set', 'cert-set');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'cert-info') THEN
        INSERT INTO role_action(action, cmd) VALUES ('cert-info', 'cert-info');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-gen-keys' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-create-csr' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-set' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='cert-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='cert-gen-keys' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='cert-create-csr' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='cert-set' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='cert-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='cert-gen-keys' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='cert-create-csr' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='cert-set' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='cert-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='cert-gen-keys' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='cert-create-csr' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='cert-set' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='cert-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

