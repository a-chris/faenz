**Faenz** is a simple, open source, lightweight and privacy friendly web analytics, alterative to Google Analytics, just like [Plausible](https://plausible.io/) but simpler and smaller. GDPR Compliant. Hostable on Heroku or your personal server with Docker images. It is written with Ruby on Rails.

# Why

I needed a GDPR compliant analytics for my personal website and my side projects so I gave the Plausible free-period a try and it was really good. At the end of the free-period I wanted to selfhost Plausible but it was too heavy for my VPS with 1 CPU and 1GB of ram where I host all my databases and personal projects. So I built my own solution using Ruby on Rails to be run on a low capable VPS and even on Heroku and similar services!

# How to selfhost/deploy

You can selfhost Faenz just by using the docker image and running it with the right environment variables. Faenz supports both SQLite and MySQL/MariaDB databases, follow the instructions in the next paragraphs.

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

### SQLite

By running Faenz with the SQLite database all the data are stored into a sqlite database created inside the docker container. It would be a really good idea to create a volume to persist the database on your file system and not lose it if something goes wrong with the container.
The required variables to use Faenz with SQLite are:

- DB=sqlite
- ADMIN_USERNAME
- ADMIN_PASSWORD

e.g.

```bash
docker run -p 3000:3000 -e DB=sqlite -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```

### MySQL

By running Faenz with the MySQL database creates a connection to a "remote" MySQL or MariaDB database where all the data will be stored. This means that the database can be on another machine or server for wich you have to specify the public IP Address and the port, or it can just be a local service or docker container on the same machine, for wich you can specify "localhost" and the port.
At the moment it works like this because the MySQL mdoe is also used by the Heroku deployment to connect to a remote database, since [Heroku can't host a SQLite database](https://devcenter.heroku.com/articles/sqlite3).
The required variables to use Faenz with MySQL/MariaDB are:

- DB=mysql
- ADMIN_USERNAME
- ADMIN_PASSWORD
- DB_HOST
- DB_PORT
- DB_PSWD
- DB_USER

e.g.

```bash
docker run -p 3000:3000 -e DB=mysql -e DB_HOST=... -e DB_PORT=3306 -e DB_PSWD=test -e DB_USER=db_user -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```

# Build the container

Be sure to have all the Ruby dependencies installed with

```bash
bundle install
```

unfortunately, at the moment you also need NodeJS on your machine to build the frontend assets which will be then copied into the Docker image. Removing this dependency is on my TODO list

```bash
yarn install
bundle exec rails assets:precompile
```

and run

```bash
docker build --tag faenz .
```

# TODO

- [ ] Release public Docker images
- [ ] Screenshots, presentation and demo of Faenz
- [ ] Remove the NodeJS dependency by using a multi-stage Docker build
- [ ] Improve UI, design, fonts, colors
- [ ] Test if Faenz can be hosted on Render
- [ ] Test if Faenz works with Heroku Postgres free-tier and in general with Prostgres database

# Contributing

Contributing to Faenz should be fair easy if you know Ruby on Rails. It's a really simple web server with controllers and Rails views. For the charts I've been using ViewComponent library, to keep each chart logic testable and apart.
