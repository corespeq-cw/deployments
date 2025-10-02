

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-rename') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-rename', 'vm-rename');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-template-local-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-template-local-list', 'vm-template-local-list');
    END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-rename' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-local-list' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-rename' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-template-local-list' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-rename' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-template-local-list' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-migrate') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-migrate', 'vm-migrate');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-migrate' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

----------


DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'domainxml-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('domainxml-list', 'domainxml-list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'domainxml-save') THEN
        INSERT INTO role_action(action, cmd) VALUES ('domainxml-save', 'domainxml-save');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'domainxml-get') THEN
        INSERT INTO role_action(action, cmd) VALUES ('domainxml-get', 'domainxml-get');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'domainxml-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('domainxml-delete', 'domainxml-delete');
    END IF;
END $$;


INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='domainxml-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='domainxml-save' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='domainxml-get' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='domainxml-delete' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='domainxml-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='domainxml-save' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='domainxml-get' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='domainxml-delete' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='domainxml-list' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='domainxml-save' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='domainxml-get' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='domainxml-delete' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='domainxml-list' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='domainxml-save' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='domainxml-get' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='domainxml-delete' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;
