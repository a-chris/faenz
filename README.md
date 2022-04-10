Faenz is a simple, open source, lightweight and privacy friendly web analytics, alterative to Google Analytics, just like [Plausible](https://plausible.io/) but easier. GDPR Compliant. Hostable on Heroku on your personal server with Docker images. It is written with Ruby on Rails.

# Why

I needed a GDPR compliant analytics so I gave the Plausible free-period a try and it was really good. At the end of the free-period I wanted to selfhost Plausible but it is too heavy for my VPS with 1 CPU and 1GB of ram where I host all my databases and personal projects. So I built my own solution using Ruby on Rails to be selfhostable on a small VPS and even on Heroku and similar services!

# How to selfhost/deploy

You can selfhost Faenz just by using the docker image and running the image with the right environment variables. Faenz supports both SQLite and MySQL/MariaDB databases, follow the instructions in the next paragraphs.

## Deploy on Heroku

The project has been written with Heroku in mind to it should be easy and not require much skills to setup.

1. Fork this project
2. Link your fork repository to Heroku
3. Setup the variables required

- BUNDLE_WITHOUT => development:test:production_sqlite
- DB => mysql
- ADMIN_PASSWORD
- ADMIN_USERNAME
- DB_HOST
- DB_PORT
- DB_PSWD
- DB_USER

4. Deploy on Heroku

## Run as a Docker container

### sqlite

Required variables for MySQL:

- DB=sqlite
- ADMIN_USERNAME
- ADMIN_PASSWORD

```bash
docker run -p 3000:3000 -e DB=sqlite -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```

### MySQL

Required variables for MySQL:

- DB=mysql
- ADMIN_USERNAME
- ADMIN_PASSWORD
- DB_HOST
- DB_PORT
- DB_PSWD
- DB_USER

```bash
docker run -p 3000:3000 -e DB=mysql -e DB_HOST=... -e DB_PORT=3306 -e DB_PSWD=test -e DB_USER=db_user -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```

# Build the container

Nothing fancy, just move in the project root folder and run

```bash
docker build --tag faenz .
```

# Contributing

Contributing to Faenz should be fair easy if you know Ruby on Rails. It's a really simple web server with controllers and Rails views. For the charts I've been using ViewComponent library, to keep each chart logic testable and apart.
