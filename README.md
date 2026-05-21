*This project has been created as part of the 42 curriculum by yaoberso.*

# Inception

## Description
The **Inception** project is a system administration exercise designed to broaden knowledge of system architecture and infrastructure setup using Docker. The primary goal is to deploy a small, secure, and isolated web infrastructure consisting of multiple services working together.

Instead of running everything on a single host, this project utilizes containerization to ensure that each service runs in its own dedicated environment, following the rule of "one container per service". The final infrastructure deploys a secure Nginx web server, a WordPress site, and a MariaDB database.

## Project Description
To achieve this architecture, the project relies heavily on **Docker** and **Docker Compose**. Docker allows us to package applications and their dependencies into standardized units called containers. 

### Sources Included and Design Choices
The infrastructure is composed of three main services:
1. **Nginx:** Acts as the entry point (Reverse Proxy/Web Server), configured to accept only secure TLSv1.2/TLSv1.3 connections on port 443.
2. **WordPress:** Runs via PHP-FPM, handling the dynamic content of the website. It is installed and configured automatically at startup using `wp-cli`.
3. **MariaDB:** The relational database that stores WordPress data safely.

**Main Design Choices:**
* **Base Images:** Containers are built from scratch using minimal base images (Alpine Linux or Debian) to keep the infrastructure lightweight and secure.
* **PID 1:** Each main process (nginx, php-fpm, mysqld) runs in the foreground as PID 1 to ensure Docker can properly monitor the container's state.
* **Automation:** No manual configuration is required after the initial launch. The entire setup (including WordPress users and database initialization) is handled by custom entrypoint scripts.

### Technical Comparisons

#### Virtual Machines vs Docker
* **Virtual Machines (VMs):** A VM includes a full "guest" operating system, virtualized hardware, and the application. It is heavy, slow to boot, and consumes significant system resources because it runs on top of a Hypervisor.
* **Docker (Containers):** Containers share the host machine's OS kernel and do not require a full guest OS. They are lightweight, boot almost instantly, and use far fewer resources, providing process-level isolation rather than hardware virtualization.

#### Secrets vs Environment Variables
* **Environment Variables (.env):** These are key-value pairs injected into a container at runtime. While convenient, they are inherently less secure as they can be exposed through command-line tools (e.g., `docker inspect`) or error logs.
* **Docker Secrets:** A more secure mechanism designed for sensitive data (like passwords or certificates). Secrets are encrypted in transit and at rest, and are typically mounted directly into the container's temporary memory (`tmpfs`), making them inaccessible to unauthorized users or outside the specific swarm/container environment.

#### Docker Network vs Host Network
* **Docker Network (e.g., Bridge):** Creates an isolated, private virtual network for containers to communicate with each other securely using internal DNS resolution (container names). The outside world cannot access these containers unless specific ports are mapped.
* **Host Network:** Removes network isolation between the container and the Docker host. The container uses the host's networking stack directly, meaning if a container binds to port 80, the host's port 80 is immediately used.

#### Docker Volumes vs Bind Mounts
* **Docker Volumes:** Storage spaces entirely managed by Docker (usually stored in `/var/lib/docker/volumes/`). They are isolated from the core host system's file structure, making them easier to back up, migrate, and manage safely across different OS environments.
* **Bind Mounts:** Maps a specific, absolute file path on the host machine (e.g., `/home/user/data`) directly to a directory inside the container. It relies heavily on the host machine's directory structure, which can cause cross-platform compatibility issues.

## Instructions

### Prerequisites
* A Linux environment (Debian) or macOS with Docker Desktop installed.
* `make` and `docker compose` must be installed.
* Local domain name resolution must be configured. 

Before running the project, add the following line to your host's `/etc/hosts` file:
`127.0.0.1    yaoberso.42.fr`

### Execution
1. Clone the repository and navigate to the project root.
2. Ensure you have created the `.env` file containing the necessary credentials at the root of the project.
3. Build and launch the infrastructure in the background by running: `make`
4. Access the website via your browser at: `https://yaoberso.42.fr`
5. Access the WordPress admin panel at: `https://yaoberso.42.fr/wp-admin`

### Useful Commands
* `make down`: Stops all containers without deleting data.
* `make clean`: Stops containers and removes the project's volumes.
* `make fclean`: Performs a full cleanup (removes containers, images, volumes, and networks).
* `make re`: Fully cleans the project and rebuilds it from scratch.

## Resources

### Documentation & References
* **Docker & Docker Compose:** [Docker Official Documentation](https://docs.docker.com/)
* **Nginx Configuration:** [Nginx Official Documentation](https://nginx.org/en/docs/) & [Mozilla SSL Configuration Generator](https://ssl-config.mozilla.org/)
* **WordPress Automation:** [WP-CLI Handbook](https://make.wordpress.org/cli/handbook/)
* **Database:** [MariaDB Knowledge Base](https://mariadb.com/kb/en/)
* **Base OS:** [Debian Documentation](https://www.debian.org/doc/) / [Alpine Linux Wiki](https://wiki.alpinelinux.org/wiki/Main_Page)

### AI Usage Statement
Artificial Intelligence (LLMs) was used during this project strictly as a learning assistant and debugging tool. AI was utilized to:
* Troubleshoot specific Docker error logs (e.g., daemon connection issues, syntax errors).
* Understand the conceptual differences between macOS and Linux file paths for bind mounts.
* Verify Makefile syntax and optimize automation rules.