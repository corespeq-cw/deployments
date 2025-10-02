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

ALTER TABLE vm_info ADD UNIQUE(name);
