Some quick scripts to open my building lobby door automatically.

Building and running:
```sh
docker build --tag app:1.0 .
docker run --publish 8080:8080 --detach --restart always --name main app:1.0
```

If nginx is required:
```sh
docker pull nginx
docker run --name docker-nginx --restart always -p 80:8080 --detach nginx
```
