#!/bin/bash

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then

    echo "Création du fichier d'initialisation SQL..."
    
    cat << EOF > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    echo "Initialisation de la base de données..."
    mysqld --user=mysql --bootstrap < /tmp/init.sql
    
    rm -f /tmp/init.sql
    echo "Base de données initialisée avec succès."
else
    echo "La base de données existe déjà. Démarrage normal."
fi

echo "Démarrage de MariaDB..."
exec mysqld_safe --user=mysql