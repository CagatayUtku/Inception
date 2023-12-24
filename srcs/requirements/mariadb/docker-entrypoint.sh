#!/bin/sh

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
# Initialize MariaDB data directory
mysql_install_db --user=mysql --ldata=/var/lib/mysql/

# Start MariaDB service
mysqld --user=mysql &

# Wait until MariaDB is up
until mysqladmin ping >/dev/null 2>&1; do
    echo -n "."; sleep 1
done

if ! mysql -u root -e "USE $WORDPRESS_DB_NAME" > /dev/null 2>&1;
then
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;"
    mysql -u root -e "GRANT ALL ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD'; FLUSH PRIVILEGES;"
    echo "Database '$WORDPRESS_DB_NAME' created with user '$WORDPRESS_DB_USER' (password: '$WORDPRESS_DB_PASSWORD')"
else
    echo "WARNING: Database '$WORDPRESS_DB_NAME' already exists"
fi
# Stop MariaDB
mysqladmin -u root shutdown

# Execute any command provided to the script
exec "$@"