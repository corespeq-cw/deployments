\set ON_ERROR_STOP 1
SET vars.cw_admin_user = :'CW_ADMIN_USER';

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM cluster_users) THEN
      INSERT INTO cluster_users (id, username, start_date, end_date, disabled) VALUES
        (1, current_setting('vars.cw_admin_user')::text, TO_CHAR(NOW() - INTERVAL '1 day', 'YYYY-MM-DD HH24:MI:SS'), TO_CHAR(NOW() + INTERVAL '1 year', 'YYYY-MM-DD HH24:MI:SS'), false);
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM cluster_user_assignment) THEN
        INSERT INTO
         cluster_user_assignment (user_id, role_id) VALUES
         (1, (SELECT id FROM roles WHERE type='cluster' and name = 'admin'));
    END IF;
END $$;


