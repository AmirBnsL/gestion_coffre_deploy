#!/bin/bash
set -e

host="$1"
port="$2"

until echo > /dev/tcp/$host/$port; do
  echo "Waiting for MySQL at $host:$port..."
  sleep 2
done

echo "MySQL is up!"
php bin/console doctrine:migrations:migrate --no-interaction
php -S 0.0.0.0:8000 -t public & cd /var/www/frontend && npm run preview -- --host 0.0.0.0 --port 5173
