FROM debian:bullseye
RUN apt-get update && apt-get install -y \
    wget \
    php7.4 \
    php7.4-fpm \
    php-mysql \
    mariadb-client
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh
WORKDIR /var/www/wordpress
CMD ["/usr/local/bin/wordpress.sh"]