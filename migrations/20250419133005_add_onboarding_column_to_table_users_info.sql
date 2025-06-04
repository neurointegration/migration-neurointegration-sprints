-- +goose Up
-- +goose StatementBegin
ALTER TABLE users_info ADD COLUMN onboarding Utf8;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
ALTER TABLE users_info DROP COLUMN onboarding;
-- +goose StatementEnd
