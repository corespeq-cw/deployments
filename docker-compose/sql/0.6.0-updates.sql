ALTER TABLE host_info ADD COLUMN IF NOT EXISTS ca TEXT;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'iso-config') THEN
        INSERT INTO role_action(action, cmd) VALUES ('iso-config', 'iso-config');
END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='iso-config' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

INSERT INTO role_action_grant (role_id, action_id) VALUES
    (  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='iso-config' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;