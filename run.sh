#!/bin/bash

# Start MariaDB service
service mysql start

# Initialize the database if it's not already present
if [ ! -d "/var/lib/mysql/grace_db" ]; then
    echo "Initializing database..."
    mysql -e "CREATE DATABASE grace_db;"
    mysql grace_db < /tmp/grace_schema.sql
    mysql -e "FLUSH PRIVILEGES;"
fi

# Start PHP-FPM
service php8.2-fpm start

# Start Nginx
nginx -g 'daemon off;'
