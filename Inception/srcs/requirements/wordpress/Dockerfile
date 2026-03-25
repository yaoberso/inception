# 1. Toujours la même base
FROM debian:bullseye

# 2. On installe les outils nécessaires
# wget : pour télécharger WordPress
# php7.4-fpm : le moteur PHP
# php-mysql : l'extension qui permet à PHP de parler à MariaDB
# mariadb-client : un outil pratique pour vérifier que la base de données est bien là
RUN apt-get update && apt-get install -y \
    wget \
    php7.4 \
    php7.4-fpm \
    php-mysql \
    mariadb-client

# 3. On installe WP-CLI (L'outil magique de WordPress en ligne de commande)
# Ça va nous éviter de configurer le site à la main sur le navigateur
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# 4. Le piège de PHP : Par défaut, PHP écoute sur un "socket" local. 
# On veut qu'il écoute sur le port 9000 pour que Nginx puisse lui parler via le réseau Docker.
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# 5. PHP a absolument besoin de ce dossier pour fonctionner, sinon il plante au démarrage
RUN mkdir -p /run/php

# 6. On copie notre futur script d'initialisation
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

# 7. On se place dans le dossier où sera notre site web
WORKDIR /var/www/wordpress

# 8. On lance notre script
CMD ["/usr/local/bin/wordpress.sh"]