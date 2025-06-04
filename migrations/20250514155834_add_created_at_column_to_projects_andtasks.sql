-- +goose Up
-- +goose StatementBegin
ALTER TABLE projects ADD COLUMN created_at Datetime;
ALTER TABLE tasks ADD COLUMN created_at Datetime;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE projects DROP COLUMN created_at;
ALTER TABLE tasks DROP COLUMN created_at;
-- +goose StatementEnd
