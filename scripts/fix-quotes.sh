#!/usr/bin/env bash
find src -type f -name "*.ts" -exec sed -i -E "s/\[\"ravenox ([^\"]+)',/\[\"ravenox \1\",/g" {} +
find src -type f -name "*.ts" -exec sed -i -E "s/\[\"ravenox ([^\"]+)\", '/\[\"ravenox \1\", \"/g" {} +
find src -type f -name "*.ts" -exec sed -i -E "s/\[\"ravenox ([^\"]+)\", \"/\[\"ravenox \1\", \"/g" {} +
find src -type f -name "*.ts" -exec sed -i -E "s/\[\"ravenox ([^\"]+)'/\[\"ravenox \1\"/g" {} +
