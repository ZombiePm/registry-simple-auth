#!/bin/bash

# Подключаем переменные из .env
set -o allexport
source .env
set +o allexport

# Проверка наличия openssl
if ! command -v openssl &> /dev/null; then
  echo "❌ OpenSSL не найден. Установите его и повторите попытку."
  exit 1
fi

# Создание htpasswd-файла
HTPASSWD_FILE="./registry-data/distribution/htpasswd"
mkdir -p ./registry-data/distribution
HASH=$(openssl passwd -bcrypt "$DOCKER_PASSWORD")
echo "$DOCKER_USERNAME:$HASH" > "$HTPASSWD_FILE"

echo "✅ htpasswd создан в $HTPASSWD_FILE"