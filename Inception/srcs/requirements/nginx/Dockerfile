FROM debian:bullseye
RUN apt-get update && apt-get install -y nginx openssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=yaoberso.42.fr/UID=yaoberso"
RUN mkdir -p /var/www/wordpress
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
RUN chown -R www-data:www-data /var/www/wordpress
CMD ["nginx", "-g", "daemon off;"]