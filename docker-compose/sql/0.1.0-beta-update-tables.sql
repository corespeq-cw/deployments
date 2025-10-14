\set ON_ERROR_STOP 1

ALTER TABLE cluster_users ADD COLUMN IF NOT EXISTS start_date varchar(50);
ALTER TABLE cluster_users ADD COLUMN IF NOT EXISTS end_date varchar(50);
ALTER TABLE cluster_users ADD COLUMN IF NOT EXISTS disabled boolean;