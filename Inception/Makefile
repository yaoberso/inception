NAME = inception
COMPOSE = srcs/docker-compose.yml

all: up

up:
	docker	compose -f $(COMPOSE) up --build

down:
	docker	compose -f $(COMPOSE) down

# Nettoie les conteneurs, les réseaux et surtout les VOLUMES créés par le projet
clean:
	docker	compose -f $(COMPOSE) down -v

# Le nettoyage nucléaire : supprime toutes les images Docker, les volumes et nettoie le système
fclean: clean
	docker	system prune -a --volumes -f

# On efface tout et on recommence
re: fclean all

.PHONY: all up down clean fclean re