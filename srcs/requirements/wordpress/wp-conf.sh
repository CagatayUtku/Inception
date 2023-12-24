#!/bin/bash

# Configuration

# Wait for mariadb to be ready
while ! mysqladmin ping -h $WORDPRESS_DB_HOST --silent; do
	sleep 1
done

# Create directory for WordPress
mkdir -p $WORDPRESS_DIR
cd $WORDPRESS_DIR

# Check if wp-config.php already exists
if [ -f $WORDPRESS_CONFIG_FILE ]; then
    echo "WARNING: WordPress already configured"
else
    # Download and install WordPress
    if wp --allow-root core download; then
        wp --allow-root core config \
		--dbname=$WORDPRESS_DB_NAME \
		--dbuser=$WORDPRESS_DB_USER \
		--dbpass=$WORDPRESS_DB_PASSWORD \
		--dbhost=$WORDPRESS_DB_HOST
        wp --allow-root core install \
		--url=$WORDPRESS_URL \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL
		wp --allow-root user create \
		$WORDPRESS_USER \
		$WORDPRESS_USER_EMAIL \
		--user_pass=$WORDPRESS_USER_PASSWORD
    else
        echo "ERROR: Failed to download WordPress"
        exit 1
    fi
fi

# Execute the provided command (passed as arguments)
exec "$@"