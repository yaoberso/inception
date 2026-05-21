```markdown
# Developer Documentation

This document provides technical details on how to set up, build, and debug the Inception architecture.

## Setting up the Environment
1. **Prerequisites:** Ensure Docker and Docker Compose are installed on your system.
2. **Local Domain:** Map the project domain to localhost by adding `127.0.0.1 yaoberso.42.fr` to your `/etc/hosts` file.
3. **Secrets & Configuration:** Create a `.env` file inside the `srcs/` directory. It must contain the necessary variables:
   - `SQL_DATABASE`, `SQL_USER`, `SQL_PASSWORD`, `SQL_ROOT_PASSWORD`
   - `WP_ADMIN_USER`, `WP_ADMIN_PASSWORD`, `WP_ADMIN_EMAIL`
   - `WP_USER`, `WP_USER_PASSWORD`, `WP_USER_EMAIL`

## Building and Launching
The infrastructure is managed via a `Makefile` at the root of the repository.
- `make all` or `make up`: Creates the host directories, builds the Docker images from the Dockerfiles, and starts the containers in detached mode.
- `make down`: Stops and removes the containers and networks created by `up`.
- `make clean`: Stops containers and removes the Docker volumes.
- `make fclean`: Performs a deep clean. It stops everything, prunes the Docker system, and forcefully removes (`rm -rf`) the local data directories to reset the environment completely.

## Relevant Management Commands
- **View logs:** `docker logs <container_name>` (e.g., `docker logs wordpress`) to debug startup scripts.
- **Access a container:** `docker exec -it <container_name> sh` to open a shell inside a running container.
- **Inspect network:** `docker network inspect inception_network` to see the internal IPs of the containers.

## Data Storage and Persistence
By default, Docker containers are ephemeral. To ensure data persists between restarts, we use **Bind Mounts**.
- The database files are stored locally at: `/home/yaoberso/data/mariadb/`
- The WordPress core files and uploads are stored locally at: `/home/yaoberso/data/wordpress/`

If you need to trigger the initial setup scripts again (e.g., to create a fresh database), you must delete the contents of these local directories using `make fclean`.