\set ON_ERROR_STOP 1
SET vars.cw_user = :'POSTGRES_CW_USER';
SET vars.cw_password = :'POSTGRES_CW_PASSWORD';

DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = current_setting('vars.cw_user')) THEN
        EXECUTE format('ALTER USER %I WITH PASSWORD %L', current_setting('vars.cw_user'), current_setting('vars.cw_password'));
    ELSE
        EXECUTE format('CREATE USER %I WITH PASSWORD %L NOINHERIT', current_setting('vars.cw_user'), current_setting('vars.cw_password'));
    END IF;
END $$;

SELECT format('CREATE DATABASE %I', :'POSTGRES_CW_DBNAME')
    WHERE NOT EXISTS (
  SELECT FROM pg_database WHERE datname = :'POSTGRES_CW_DBNAME'
)\gexec


REVOKE CONNECT ON DATABASE :POSTGRES_CW_DBNAME FROM PUBLIC;
GRANT CONNECT ON DATABASE :POSTGRES_CW_DBNAME TO :POSTGRES_CW_USER;
GRANT ALL PRIVILEGES ON DATABASE :POSTGRES_CW_DBNAME TO :POSTGRES_CW_USER;
\connect :POSTGRES_CW_DBNAME;
GRANT ALL ON SCHEMA public TO :POSTGRES_CW_USER;
