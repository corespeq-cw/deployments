\set ON_ERROR_STOP 1

CREATE TABLE IF NOT EXISTS vm_xmls (
    ID                 SERIAL               NOT NULL,
    vm_id              int                  NOT NULL,
    xml_key            varchar(50)          NOT NULL,
    xml_string         TEXT,
    cmd_type           varchar(50),
    user_id            int,
    inserted_ts        timestamp,
    PRIMARY KEY (ID),
    UNIQUE(vm_id, xml_key)
);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conrelid = 'vm_info'::regclass
          AND conname = 'vm_info_name_key'
    ) THEN
    ALTER TABLE vm_info ADD CONSTRAINT vm_info_name_key UNIQUE (name);
    END IF;
END$$;

