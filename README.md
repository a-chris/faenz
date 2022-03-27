# Deploy on Heroku

The project has been written with Heroku in mind to it should be easy and not require much skills to setup.

1. Fork this project
2. Link your fork repository to Heroku
3. Setup the variables required
  - BUNDLE_WITHOUT  => development:test:production_sqlite
  - DB              => mysql
  - ADMIN_PASSWORD
  - ADMIN_USERNAME
  - DB_HOST
  - DB_PORT
  - DB_PSWD
  - DB_USER
4. Deploy on Heroku

# Build the container

Nothing fancy, just move in the project root folder and run
```bash
docker build --tag faenz .
```

# Run the container for the first time

## sqlite
Required variables for MySQL:
- DB=sqlite
- ADMIN_USERNAME
- ADMIN_PASSWORD

```bash
docker run -p 3000:3000 -e DB=sqlite -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```

## MySQL
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
