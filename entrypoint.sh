#!/bin/sh

# Ждем, пока база данных станет доступной
echo "Waiting for database..."
/usr/src/app/node_modules/.bin/prisma migrate deploy --schema=./prisma/schema.prisma || exit 1
echo "Database migrations applied."

# Запускаем приложение
exec "$@"