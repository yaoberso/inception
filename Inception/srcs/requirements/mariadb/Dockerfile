# 1. On part de l'image Debian
FROM debian:bullseye

# 2. On installe MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# 3. Le fameux piège : on autorise MariaDB à écouter les autres conteneurs (0.0.0.0)
RUN sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# 4. On copie notre script d'initialisation dans le conteneur
COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

# 5. On donne les droits d'exécution au script (avec son chemin DANS le conteneur)
RUN chmod +x /usr/local/bin/mariadb.sh

# 6. On lance le script au démarrage du conteneur
CMD ["/usr/local/bin/mariadb.sh"]