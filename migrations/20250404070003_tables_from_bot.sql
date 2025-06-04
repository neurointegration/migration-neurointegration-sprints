-- +goose Up
-- +goose StatementBegin

CREATE TABLE IF NOT EXISTS current_scenarios (
    chat_id Int64 NOT NULL,
    scenario_id Int64 NOT NULL,
    current_sprint_number Int64,
    sprint_reply_number Int32,
    index Int32,
    date Datetime,
    PRIMARY KEY (chat_id)
);

CREATE TABLE IF NOT EXISTS routine_actions_info (
    user_id Int64 NOT NULL,
    sprint_number Int64 NOT NULL,
    action_id Utf8 NOT NULL,
    type Utf8 NOT NULL,
    action Utf8 NOT NULL,
    week_one Int32 NOT NULL,
    week_two Int32 NOT NULL,
    week_three Int32 NOT NULL,
    week_four Int32 NOT NULL,
    PRIMARY KEY (user_id, sprint_number, action_id)
);

CREATE TABLE IF NOT EXISTS scenario_state (
    date Datetime,
    data Json,
    chat_id Int64 NOT NULL,
    scenario_id Utf8 NOT NULL,
    current_sprint_number Int64,
    sprint_reply_number Int32,
    index Int32,
    PRIMARY KEY (chat_id)
);

CREATE TABLE IF NOT EXISTS scenarios (
    scenario_id Int64 NOT NULL,
    message_index Int32 NOT NULL,
    message Utf8,
    answer_key Utf8,
    PRIMARY KEY (scenario_id, message_index)
);

CREATE TABLE IF NOT EXISTS scenarios_to_start (
    scenario_to_start_id Utf8 NOT NULL,
    chat_id Int64 NOT NULL,
    scenario_id Utf8 NOT NULL,
    scenario_type Utf8 NOT NULL,
    current_sprint_number Int64 NOT NULL,
    sprint_reply_number Int32 NOT NULL,
    is_delayed Bool NOT NULL,
    priority Int32 NOT NULL,
    date Datetime,
    data Json,
    PRIMARY KEY (scenario_to_start_id)
);

CREATE TABLE IF NOT EXISTS sprints_info (
    pleasure_count Int32,
    user_id Int64 NOT NULL,
    sprint_number Int64 NOT NULL,
    sprint_start_date Date NOT NULL,
    sheet_id Utf8 NOT NULL,
    life_count Int32,
    drive_count Int32,
    PRIMARY KEY (user_id, sprint_number)
);

CREATE TABLE IF NOT EXISTS user_answers (
    pk Int64 NOT NULL,
    chat_id Int64 NOT NULL,
    key Utf8 NOT NULL,
    answer Utf8 NOT NULL,
    PRIMARY KEY (pk)
);

CREATE TABLE IF NOT EXISTS user_questions (
    is_delayed Bool,
    date Datetime NOT NULL,
    user_id Int64 NOT NULL,
    scenario_type Utf8 NOT NULL,
    priority Int32 NOT NULL,
    sprint_reply_number Int32 NOT NULL,
    sprint_number Int64 NOT NULL,
    PRIMARY KEY (date, user_id)
);

CREATE TABLE IF NOT EXISTS user_sprint_answers (
    sprint_reply_number Int32 NOT NULL,
    sprint_number Int64 NOT NULL,
    date Date NOT NULL,
    user_id Int64 NOT NULL,
    answer Utf8,
    scenario_type Utf8 NOT NULL,
    answer_number Int32 NOT NULL,
    PRIMARY KEY (user_id, sprint_number, scenario_type, sprint_reply_number, answer_number)
);

CREATE TABLE IF NOT EXISTS user_sprint_answers2 (
    sprint_number Int64 NOT NULL,
    sprint_reply_number Int32 NOT NULL,
    user_id Int64 NOT NULL,
    date Date NOT NULL,
    answer Utf8 NOT NULL,
    scenario_type Utf8 NOT NULL,
    answer_type Utf8 NOT NULL,
    PRIMARY KEY (user_id, scenario_type, answer_type, sprint_number, sprint_reply_number)
);

CREATE TABLE IF NOT EXISTS users_access (
    granted_user_id Int64 NOT NULL,
    owner_user_id Int64 NOT NULL,
    permission_id Utf8 NOT NULL,
    sheet_id Utf8 NOT NULL,
    PRIMARY KEY (granted_user_id, owner_user_id, sheet_id)
);

CREATE TABLE IF NOT EXISTS users_info (
    chat_id Int64 NOT NULL,
    email Utf8 NOT NULL,
    username Utf8 NOT NULL,
    iam_coach Bool NOT NULL,
    send_regular_messages Bool NOT NULL,
    evening_standup_time Interval,
    week_reflection_time Interval,
    start_message_time Interval,
    end_message_time Interval,
    routine_actions Utf8,
    PRIMARY KEY (chat_id)
);

CREATE TABLE IF NOT EXISTS users_repo (
    chat_id Int64 NOT NULL,
    i_am_coach Utf8 NOT NULL,
    send_regular_messages Utf8 NOT NULL,
    PRIMARY KEY (chat_id)
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP TABLE IF EXISTS users_repo;
DROP TABLE IF EXISTS users_info;
DROP TABLE IF EXISTS users_access;
DROP TABLE IF EXISTS user_sprint_answers2;
DROP TABLE IF EXISTS user_sprint_answers;
DROP TABLE IF EXISTS user_questions;
DROP TABLE IF EXISTS user_answers;
DROP TABLE IF EXISTS sprints_info;
DROP TABLE IF EXISTS scenarios_to_start;
DROP TABLE IF EXISTS scenarios;
DROP TABLE IF EXISTS scenario_state;
DROP TABLE IF EXISTS routine_actions_info;
DROP TABLE IF EXISTS current_scenarios;

-- +goose StatementEnd
