# Build the container
Move in the project root folter and run
```bash
docker build --tag faenz .
```

# Run the container for the first time
```bash
docker run -p 3000:3000 -e ADMIN_USERNAME=admin -e ADMIN_PASSWORD=test faenz
```