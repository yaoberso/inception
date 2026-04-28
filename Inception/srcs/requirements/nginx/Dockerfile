# 1. On part de l'image Debian (la version stable actuelle ou l'avant-dernière)
FROM debian:bullseye

# 2. On installe NGINX et OpenSSL (l'outil pour créer les certificats de sécurité)
RUN apt-get update && apt-get install -y nginx openssl

# 3. On crée un dossier pour ranger nos certificats SSL
RUN mkdir -p /etc/nginx/ssl

# 4. On génère le certificat de sécurité auto-signé
# (Le -subj permet de remplir automatiquement les questions posées par openssl comme le pays, la ville, etc.)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=yaoberso.42.fr/UID=yaoberso"

# 5. On crée le dossier qui va contenir les fichiers du site web
RUN mkdir -p /var/www/wordpress

# 6. On copie le fichier de configuration qu'on a créé sur notre PC vers le conteneur
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# 7. On donne les droits au bon utilisateur (www-data est l'utilisateur par défaut des serveurs web sur Debian)
RUN chown -R www-data:www-data /var/www/wordpress

# 8. La commande pour lancer NGINX au premier plan (règle du PID 1)
CMD ["nginx", "-g", "daemon off;"]