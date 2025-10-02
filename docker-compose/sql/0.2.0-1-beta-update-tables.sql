DROP VIEW IF EXISTS cluster_user_roles;

CREATE TABLE IF NOT EXISTS roles (
    ID                 SERIAL               NOT NULL,
    name               varchar(50),
    type               varchar(50),
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS role_action (
    ID                 SERIAL               NOT NULL,
    action             varchar(50),
    cmd                varchar(50),
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS role_action_grant (
    role_id                 int               NOT NULL,
    action_id               int               NOT NULL,
    PRIMARY KEY (role_id, action_id)
);

CREATE TABLE IF NOT EXISTS host_user_assignment (
    ID                    SERIAL        NOT NULL,
    user_id               int           NOT NULL,
    host_id               int           NOT NULL,
    role_id               int           NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS cluster_user_assignment (
    ID                    SERIAL        NOT NULL,
    user_id               int           NOT NULL,
    role_id               int           NOT NULL,
    PRIMARY KEY (ID)
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM roles) THEN
        INSERT INTO roles(name, type) VALUES ('admin', 'cluster');
        INSERT INTO roles(name, type) VALUES ('admin', 'host');
        INSERT INTO roles(name, type) VALUES ('poweruser', 'host');
        INSERT INTO roles(name, type) VALUES ('user', 'vm');

        INSERT INTO roles(name, type) VALUES ('admin', 'host-global');
        INSERT INTO roles(name, type) VALUES ('poweruser', 'host-global');
        INSERT INTO roles(name, type) VALUES ('user', 'vm-global');
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM cluster_user_assignment) THEN
        INSERT INTO cluster_user_assignment (user_id, role_id)
        SELECT p1.id, p0.id
        FROM  (select id from roles where name='admin' and type='cluster') p0
            , (select id from cluster_users where is_admin=true) p1
        ;
    END IF;
END $$;

-- insert/update pre-existing data
ALTER TABLE cluster_users DROP COLUMN is_admin;

ALTER TABLE vm_user_assignment ADD role_id int;
ALTER TABLE vm_user_assignment ADD ID SERIAL NOT NULL;
UPDATE vm_user_assignment
SET role_id=p0.id
FROM  (select id from roles where name='user' and type='vm') p0
where role_id is null;
ALTER TABLE vm_user_assignment drop constraint vm_user_assignment_pkey;
ALTER TABLE vm_user_assignment add constraint vm_user_assignment_pkey primary key (ID);

ALTER TABLE vm_user_assignment ADD UNIQUE (user_id, vm_id, role_id);
ALTER TABLE host_user_assignment ADD UNIQUE (user_id, host_id);
ALTER TABLE cluster_user_assignment ADD UNIQUE (user_id, role_id);

CREATE VIEW cluster_user_roles AS
SELECT a.user_id, a.role_id, b.name, b.type FROM cluster_user_assignment a, roles b WHERE a.role_id = b.id
UNION SELECT a.user_id, a.role_id, b.name, b.type FROM host_user_assignment a, roles b WHERE a.role_id = b.id
UNION SELECT a.user_id, a.role_id, b.name, b.type FROM vm_user_assignment a, roles b WHERE a.role_id = b.id;