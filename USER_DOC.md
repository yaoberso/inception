```markdown
# User Documentation

This guide explains how to use and manage the Inception web infrastructure.

## Provided Services
This stack provides a fully functional, secure WordPress website. Under the hood, it uses:
- **NGINX:** Secures the connection (HTTPS) and displays the website.
- **WordPress:** The interface where you can read and write articles.
- **MariaDB:** A hidden database that securely stores all the website's text and user accounts.

## How to Start and Stop the Project
Open a terminal in the root directory of the project.
- **To start the project:** run `make` or `make up`. The website will be available in a few seconds.
- **To stop the project:** run `make down`. The website will go offline, but your data (articles, users) will be saved.

## Accessing the Website and Administration Panel
Once the project is running:
- **Website:** Open your browser and go to `https://yaoberso.42.fr` (You will need to accept the self-signed SSL certificate warning).
- **Admin Panel:** Go to `https://yaoberso.42.fr/wp-admin` to log in and manage the site.

## Locating and Managing Credentials
All passwords and usernames (Database root password, WordPress admin, etc.) are stored in a hidden file named `.env` located inside the `srcs/` directory. 
*Note: If you change these passwords after the first launch, you will need to completely wipe the database using `make fclean` to apply the new credentials.*

## Checking Services
To verify that everything is running smoothly, open a terminal and run:
```bash
docker ps