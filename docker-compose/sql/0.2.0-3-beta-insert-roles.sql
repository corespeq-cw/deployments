-- role
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-list', 'vm-list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-list-host') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-list-host', 'vm-list-host');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'update-vminfo') THEN
        INSERT INTO role_action(action, cmd) VALUES ('update-vminfo', 'update-vminfo');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'update-vminfo-all') THEN
        INSERT INTO role_action(action, cmd) VALUES ('update-vminfo-all', 'update-vminfo-all');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'delete-vminfo') THEN
        INSERT INTO role_action(action, cmd) VALUES ('delete-vminfo', 'delete-vminfo');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'snap-list-all') THEN
        INSERT INTO role_action(action, cmd) VALUES ('snap-list-all', 'snapshots-list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignments') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignments', 'assignments');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignment-add') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignment-add', 'assignment-add');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignment-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignment-delete', 'assignment-delete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'systeminfo') THEN
        INSERT INTO role_action(action, cmd) VALUES ('systeminfo', 'host-info');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'get-host-env') THEN
        INSERT INTO role_action(action, cmd) VALUES ('get-host-env', 'get-host-env');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'set-host-env') THEN
        INSERT INTO role_action(action, cmd) VALUES ('set-host-env', 'set-host-env');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vmcreate') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vmcreate', 'vmcreate');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vmdelete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vmdelete', 'vmdelete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-hostdev-attach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-hostdev-attach', 'vm-hostdev-attach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-hostdev-detach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-hostdev-detach', 'vm-hostdev-detach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-disk-attach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-disk-attach', 'vm-disk-attach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-disk-detach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-disk-detach', 'vm-disk-detach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-bridge-attach') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-bridge-attach', 'vm-bridge-attach');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-template') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-template', 'vm-template');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-clone') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-clone', 'vm-clone');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-template-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-template-list', 'vm-template-list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-template-dumpxml') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-template-dumpxml', 'vm-template-dumpxml');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'users') THEN
        INSERT INTO role_action(action, cmd) VALUES ('users', 'users');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'user-add') THEN
        INSERT INTO role_action(action, cmd) VALUES ('user-add', 'user-add');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'user-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('user-delete', 'user-delete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'user-set') THEN
        INSERT INTO role_action(action, cmd) VALUES ('user-set', 'user-set');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'hosts') THEN
        INSERT INTO role_action(action, cmd) VALUES ('hosts', 'hosts');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'host-add') THEN
        INSERT INTO role_action(action, cmd) VALUES ('host-add', 'host-add');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'host-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('host-delete', 'host-delete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list', 'list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'start') THEN
        INSERT INTO role_action(action, cmd) VALUES ('start', 'vmstart');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'shutdown') THEN
        INSERT INTO role_action(action, cmd) VALUES ('shutdown', 'vmshutdown');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'destroy') THEN
        INSERT INTO role_action(action, cmd) VALUES ('destroy', 'vmdestroy');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'dumpxml') THEN
        INSERT INTO role_action(action, cmd) VALUES ('dumpxml', 'dumpxml');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vncdisplay') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vncdisplay', 'vncdisplay');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-info') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-info', 'vm-info');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'snap-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('snap-list', 'snapshots');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'take-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('take-snap', 'take-snap');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'delete-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('delete-snap', 'delete-snap');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'rollback') THEN
        INSERT INTO role_action(action, cmd) VALUES ('rollback', 'rollback');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'dumpxml-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('dumpxml-snap', 'dumpxml-snap');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'local-snapshots') THEN
        INSERT INTO role_action(action, cmd) VALUES ('local-snapshots', 'local-snapshots');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'take-local-snap') THEN
        INSERT INTO role_action(action, cmd) VALUES ('take-local-snap', 'take-local-snap');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'version') THEN
        INSERT INTO role_action(action, cmd) VALUES ('version', 'version');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignments-host') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignments-host', 'assignments-host');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignment-host-add') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignment-host-add', 'assignment-host-add');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'assignment-host-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('assignment-host-delete', 'assignment-host-delete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'help-admin') THEN
        INSERT INTO role_action(action, cmd) VALUES ('help-admin', 'help-admin');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'group-list') THEN
        INSERT INTO role_action(action, cmd) VALUES ('group-list', 'group-list');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'groups') THEN
        INSERT INTO role_action(action, cmd) VALUES ('groups', 'groups');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'group-add') THEN
        INSERT INTO role_action(action, cmd) VALUES ('group-add', 'group-add');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'group-delete') THEN
        INSERT INTO role_action(action, cmd) VALUES ('group-delete', 'group-delete');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'group-add-vm') THEN
        INSERT INTO role_action(action, cmd) VALUES ('group-add-vm', 'group-add-vm');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'group-remove-vm') THEN
        INSERT INTO role_action(action, cmd) VALUES ('group-remove-vm', 'group-remove-vm');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'list-vxlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('list-vxlan', 'list-vxlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'register-vxlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('register-vxlan', 'register-vxlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'deregister-vxlan') THEN
        INSERT INTO role_action(action, cmd) VALUES ('deregister-vxlan', 'deregister-vxlan');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'get-commands') THEN
        INSERT INTO role_action(action, cmd) VALUES ('get-commands', 'get-commands');
    END IF;

    IF NOT EXISTS (SELECT 1 FROM role_action WHERE action = 'vm-domain-info') THEN
        INSERT INTO role_action(action, cmd) VALUES ('vm-domain-info', 'vm-domain-info');
    END IF;
END $$;

INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-list-host' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='update-vminfo' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='update-vminfo-all' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='delete-vminfo' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='snap-list-all' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignments' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignment-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignment-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignments-host' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignment-host-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='assignment-host-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='systeminfo' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='get-host-env' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='set-host-env' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vmcreate' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vmdelete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-hostdev-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-hostdev-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-disk-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-disk-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-bridge-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-clone' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-template-dumpxml' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='users' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='user-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='user-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='user-set' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='hosts' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='host-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='host-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='start' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='shutdown' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='destroy' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='dumpxml' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vncdisplay' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-info' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='snap-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='take-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='delete-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='rollback' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='dumpxml-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='local-snapshots' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='take-local-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='group-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='groups' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='group-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='group-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='group-add-vm' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='group-remove-vm' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='list-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='register-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='deregister-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='help-admin' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='get-commands' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='vm-domain-info' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='cluster'), (SELECT ID from role_action WHERE action='version' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- host admin
--  host-global
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='vm-list-host' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='snap-list' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='assignments' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='groups' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='group-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='group-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='help-admin' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='get-commands' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host-global'), (SELECT ID from role_action WHERE action='version' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--  regular
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='assignment-add' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='assignment-delete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='systeminfo' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='get-host-env' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vmcreate' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vmdelete' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-hostdev-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-hostdev-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-disk-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-disk-detach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-bridge-attach' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-template' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-clone' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-template-dumpxml' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='start' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='shutdown' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='destroy' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='dumpxml' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vncdisplay' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-info' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='take-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='delete-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='rollback' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='dumpxml-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='local-snapshots' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='take-local-snap' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='group-add-vm' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='group-remove-vm' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='list-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='register-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='deregister-vxlan' )    ),
(  (SELECT ID from roles WHERE name='admin' and type='host'), (SELECT ID from role_action WHERE action='vm-domain-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;


-- host poweruser
--   host-global
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='vm-list-host' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='list' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='snap-list' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='assignments' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='groups' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='group-add' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='group-delete' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='help-admin' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='get-commands' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host-global'), (SELECT ID from role_action WHERE action='version' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--  regular
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='assignment-add' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='assignment-delete' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='systeminfo' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='get-host-env' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vmcreate' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vmdelete' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-template' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-clone' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-template-dumpxml' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='start' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='shutdown' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='destroy' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='dumpxml' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vncdisplay' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-info' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='take-snap' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='delete-snap' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='rollback' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='dumpxml-snap' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='local-snapshots' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='take-local-snap' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='group-add-vm' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='group-remove-vm' )    ),
(  (SELECT ID from roles WHERE name='poweruser' and type='host'), (SELECT ID from role_action WHERE action='vm-domain-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;

-- vm user
--   vm-global
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='list')    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='snap-list')    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='groups')    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='group-add')    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='group-delete')    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='get-commands' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm-global'), (SELECT ID from role_action WHERE action='version')    )
ON CONFLICT (role_id, action_id) DO NOTHING;

--   regular
INSERT INTO role_action_grant (role_id, action_id) VALUES
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='start')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='shutdown')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='destroy')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='dumpxml')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='vncdisplay')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='vm-info')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='take-snap')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='delete-snap')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='rollback')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='dumpxml-snap')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='local-snapshots')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='take-local-snap')      ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='group-add-vm' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='group-remove-vm' )    ),
(  (SELECT ID from roles WHERE name='user' and type='vm'), (SELECT ID from role_action WHERE action='vm-domain-info' )    )
ON CONFLICT (role_id, action_id) DO NOTHING;



