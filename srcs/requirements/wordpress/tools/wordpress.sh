#!/bin/bash
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "En attente de MariaDB..."
while ! mariadb -h mariadb -u $SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done
echo "MariaDB est prêt ! Connexion réussie."

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installation de WordPress..."

    wp core download --allow-root --path=/var/www/wordpress

    wp config create --allow-root \
                     --dbname=$SQL_DATABASE \
                     --dbuser=$SQL_USER \
                     --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb:3306 \
                     --path=/var/www/wordpress

    wp core install --allow-root \
                    --url=$DOMAIN_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --path=/var/www/wordpress

    wp user create --allow-root \
                   $WP_USER \
                   $WP_USER_EMAIL \
                   --role=author \
                   --user_pass=$WP_USER_PASSWORD \
                   --path=/var/www/wordpress

    echo "WordPress installé et configuré avec succès !"
else
    echo "WordPress est déjà installé."
fi

echo "Démarrage de PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F