#!/bin/bash

# 1. On donne les droits au dossier (juste au cas où)
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# 2. La boucle d'attente magique
# WordPress attend que la base de données MariaDB soit prête à l'écouter
echo "En attente de MariaDB..."
while ! mariadb -h mariadb -u $SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done
echo "MariaDB est prêt ! Connexion réussie."

# 3. On vérifie si WordPress est déjà installé
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installation de WordPress..."

    # On télécharge les fichiers de WordPress
    wp core download --allow-root --path=/var/www/wordpress

    # On crée le fichier de configuration (wp-config.php) pour lier WP à la base de données
    wp config create --allow-root \
                     --dbname=$SQL_DATABASE \
                     --dbuser=$SQL_USER \
                     --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb:3306 \
                     --path=/var/www/wordpress

    # On installe le site avec le compte Administrateur
    wp core install --allow-root \
                    --url=$DOMAIN_NAME \
                    --title="$WP_TITLE" \
                    --admin_user=$WP_ADMIN_USER \
                    --admin_password=$WP_ADMIN_PASSWORD \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --path=/var/www/wordpress

    # On crée le deuxième utilisateur demandé par le sujet (un simple "Auteur")
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

# 4. On lance PHP-FPM au premier plan (Le fameux PID 1 pour garder le conteneur allumé)
echo "Démarrage de PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F