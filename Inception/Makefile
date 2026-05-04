NAME = inception
COMPOSE = srcs/docker-compose.yml

all: up

up:
	mkdir -p $(HOME)/data/mariadb
	mkdir -p $(HOME)/data/wordpress
	docker compose -f $(COMPOSE) up -d --build

down:
	docker compose -f $(COMPOSE) down

clean:
	docker compose -f $(COMPOSE) down -v

fclean: clean
	docker system prune -a --volumes -f

re: fclean all

.PHONY: all up down clean fclean re