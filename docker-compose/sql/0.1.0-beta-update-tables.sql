ALTER TABLE cluster_users ADD COLUMN start_date varchar(50);
ALTER TABLE cluster_users ADD COLUMN end_date   varchar(50);
ALTER TABLE cluster_users ADD COLUMN disabled boolean;