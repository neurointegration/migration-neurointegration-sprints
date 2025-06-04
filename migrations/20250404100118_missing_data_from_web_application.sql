-- +goose Up
-- +goose StatementBegin

ALTER TABLE users_info ADD COLUMN name Utf8;
ALTER TABLE users_info ADD COLUMN is_onboarding_complete Bool;
ALTER TABLE users_info ADD COLUMN about_me Utf8;
ALTER TABLE users_info ADD COLUMN sprint_weeks_count Int32;
ALTER TABLE users_info ADD COLUMN photo_url Utf8;
ALTER TABLE users_info ADD COLUMN password_hash Utf8;

ALTER TABLE sprints_info ADD COLUMN weeks_count Int32;

ALTER TABLE users_access ADD COLUMN trainer_comment Utf8;

CREATE TABLE IF NOT EXISTS projects (
    project_id Uuid NOT NULL,
    chat_id Int64 NOT NULL,
    sprint_number Int64 NOT NULL,
    section_name Utf8 NOT NULL,
    title Utf8 NOT NULL,
    planning_times Utf8,
    fact_times Utf8,
    PRIMARY KEY (chat_id, sprint_number, project_id)
);

CREATE TABLE IF NOT EXISTS tasks (
    task_id Uuid NOT NULL,
    project_id Uuid NOT NULL,
    section_name Utf8 NOT NULL,
    title Utf8 NOT NULL,
    planning_times Utf8,
    fact_times Utf8,
    PRIMARY KEY (task_id, project_id)
);

CREATE TABLE IF NOT EXISTS refresh_tokens (
    token_id Uuid NOT NULL,
    chat_id Int64 NOT NULL,
    token_hash Utf8 NOT NULL,
    created_at Datetime NOT NULL,
    expires_at Datetime NOT NULL,
    PRIMARY KEY (token_hash, expires_at, chat_id, token_id)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

ALTER TABLE users_info DROP COLUMN name;
ALTER TABLE users_info DROP COLUMN is_onboarding_complete;
ALTER TABLE users_info DROP COLUMN about_me;
ALTER TABLE users_info DROP COLUMN sprint_weeks_count;
ALTER TABLE users_info DROP COLUMN photo_url;
ALTER TABLE users_info DROP COLUMN password_hash;

ALTER TABLE sprints_info DROP COLUMN weeks_count;

ALTER TABLE users_access DROP COLUMN trainer_comment;

DROP TABLE IF EXISTS projects;

DROP TABLE IF EXISTS tasks;

DROP TABLE IF EXISTS refresh_tokens;

-- +goose StatementEnd
