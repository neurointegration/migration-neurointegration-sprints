# Миграции базы данных с помощью Goose

В качестве инструмента для управления миграциями базы данных YDB используется [goose](https://github.com/pressly/goose). Запросы к базе данных пишутся на языке YQL.

## Установка

Инструкцию по установке goose можно найти в [официальной документации](https://pressly.github.io/goose/installation/).

## Конфигурация

Все файлы миграций находятся в директории `migrations`. Создавать и применять миграции необходимо, находясь в этой папке.

### Строка подключения

Для взаимодействия с Serverless YDB используется специально сформированная строка подключения.

**Пример строки подключения:**
```
grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***?token=<IAM_TOKEN>&go_query_mode=scripting&go_fake_tx=scripting&go_query_bind=declare,numeric
```

**Компоненты строки подключения:**

*   **Endpoint:** Часть строки `grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***` является эндпоинтом вашей базы данных. Его можно скопировать из веб-интерфейса Yandex Cloud. Обратите внимание, что из скопированного эндпоинта нужно удалить фрагмент `?database=`.
*   **IAM-токен:** Для аутентификации используется IAM-токен. Чтобы сгенерировать токен, выполните в терминале команду Yandex Cloud CLI:
    ```bash
    yc iam create-token
    ```
    Полученный токен необходимо подставить вместо `<IAM_TOKEN>` в строке подключения.
*   **Параметры YDB-драйвера (Изменять не нужно):**
    *   `go_query_mode=scripting`: Этот параметр включает специальный режим для выполнения запросов по умолчанию в драйвере YDB. В этом режиме все запросы от goose отправляются в скриптовый сервис YDB, что позволяет обрабатывать как DDL, так и DML SQL-инструкции.
    *   `go_fake_tx=scripting`: Включает эмуляцию транзакций при выполнении запросов через скриптовый сервис YDB. Это необходимо, поскольку в YDB выполнение DDL-инструкций в транзакции невозможно или сопряжено со значительными накладными расходами.
    *   `go_query_bind=declare,numeric`: Обеспечивает поддержку биндингов для автоматического вывода типов YQL из параметров запроса (`declare`) и поддержку нумерованных параметров (`numeric`), которые генерирует ядро goose.

## Основные команды

Все команды goose выполняются из директории `migrations`.

### Создание новой миграции

Для создания нового файла миграции используется команда `create`.

**Пример:**
```bash
goose ydb "grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***?token=<IAM_TOKEN>&go_query_mode=scripting&go_fake_tx=scripting&go_query_bind=declare,numeric" create create_first_table sql
```
Эта команда создаст SQL-файл с временной меткой и названием `create_first_table` в папке `migrations`. В этом файле будут два блока: `-- +goose Up` для написания запросов миграции и `-- +goose Down` для запросов отката миграции.

### Применение миграций

Для применения всех доступных миграций используется команда `up`.

**Пример:**
```bash
goose ydb "grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***?token=<IAM_TOKEN>&go_query_mode=scripting&go_fake_tx=scripting&go_query_bind=declare,numeric" up
```

### Откат последней миграции

Для отмены последней примененной миграции используется команда `down`.

**Пример:**
```bash
goose ydb "grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***?token=<IAM_TOKEN>&go_query_mode=scripting&go_fake_tx=scripting&go_query_bind=declare,numeric" down
```

**Внимание:** Будьте осторожны при использовании команды `down`. Если в секции `-- +goose Down` вашей миграции прописано удаление таблицы, то эта таблица будет безвозвратно удалена из базы данных.

### Просмотр статуса миграций

Чтобы увидеть, какие миграции были применены, а какие еще нет, используйте команду `status`.

**Пример:**
```bash
goose ydb "grpcs://ydb.serverless.yandexcloud.net:2135/ru-central1/b1g***/etn***?token=<IAM_TOKEN>&go_query_mode=scripting&go_fake_tx=scripting&go_query_bind=declare,numeric" status
```