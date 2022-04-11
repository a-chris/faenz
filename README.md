**Faenz** is a simple, open source, lightweight and privacy friendly web analytics, alterative to Google Analytics, just like [Plausible](https://plausible.io/) but simpler and smaller. GDPR Compliant. Cookie-free. Hostable on Heroku or your personal server with Docker images. Written with Ruby on Rails.

![dashboard](readme/dashboard.jpeg)

# Why

I needed a GDPR compliant analytics for my personal website and my side projects so I gave the Plausible free-period a try and it was really good. At the end of the free-period I wanted to selfhost Plausible but it was too heavy for my VPS with 1 CPU and 1GB of ram, that I also use for all my databases and personal projects. So I built my own solution using Ruby on Rails to be run on a low capable VPS and even on Heroku and similar services!

To be honest, I didn't even read the Plausible source code. I just thought I could re-implement most of Plausible features by knowing how it works from the user perspective.

# Data Policy

Faenz only collect these information:

- referrer: the page from which the user is coming from (e.g. google, facebook, twitter, etc..)
- url: the url of the page loaded (e.g. https://yoursite.com/home)
- width: the width, in pixel, of the device used to load the page (e.g. 1920)
- user IP Address: the user IP is needed to calculate some metrics like the bounce rate, but is not used to track the user activity. **The IP address is mixed with a random salt and is encrypted. A new salt is generated every 24 hours, so there's no way to know if a user have been visiting your website two days in a row.** [That's also how Plausible works](https://plausible.io/data-policy).

# How it works

## Traditional way

First of all you need to host the Faenz instance, login in the dashboard and add a new domain to your domains list by typing its url and favicon url.

Then you need to load the Faenz [Javascript file](https://github.com/a-chris/faenz/blob/main/public/faenz.js) into your website pages, the code will send a HTTP request when the page is loaded on the user's browser so that Faenz can collect the information regarding the user visit on your website.

Assuming that you are hosting Faenz on you webserver available at `https://myfaenz.com` and you want to collect analytics data for `https://mywebsite.com` then you need to add this code to your website pages:

```javascript
<script defer data-domain="https://mywebsite.com" src="https://myfaenz.com/faenz.js" />
```

that's all. Go to your Faenz dashboard and enjoy the realtime statistics.

## Server side

A new intriguing solution: server-side analytics. You can send HTTP request from your server directly to Faenz to collect data regarding user visits, just like before, but being sure that every visit is collected and not blocked by an ad-blocker or because the user has turned off Javascript.

Moreover, you can use Faenz to collect data about how your code is working, for example I have some period tasks which run on my VPS and I'm using Faenz to log when the tasks run and what's the output. Of course, doing this, the width, referrer, etc.. is going to stay empty and unused.

For this you just need to send HTTP `POST` requests to `https://myfaenz.com/api/event` with the following body:

```javascript
{
  "d": "mywebsite.com",
  "n": "pageview",
  "r": "google.com",
  "u": "https://mywebsite.com",
  "w": 967
}
```

I'm planning to support more fields in the future for more advanced use cases.

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
- [ ] Support import and export of data, also compatible with Plausible exports
- [ ] Allowing to collect extra and complex fields
- [ ] Configurable charts (hide or add some charts)
- [ ] Remove the NodeJS dependency by using a multi-stage Docker build
- [ ] Improve UI, design, fonts, colors
- [ ] Test if Faenz can be hosted on Render
- [ ] Test if Faenz works with Heroku Postgres free-tier and in general with Prostgres database

# Contributing

Contributing to Faenz should be fair easy if you know Ruby on Rails. It's a really simple web server with controllers and Rails views. For the charts I've been using ViewComponent library, to keep each chart logic testable and apart.
