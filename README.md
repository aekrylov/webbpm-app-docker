# webbpm-app-docker - Dockerized webbpm-app

The image is based on DCEVM-enabled JDK and webbpm-app-prod

## Building the base image
You need to specify webbpm-app version
`docker build --build-arg APP_VERSION=<webbpm-app-prod version> .`

## Running the base image
1. Mount `standalone.xml`:

    ```bash
    docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787 \
     -v $(pwd)/standalone.xml:/config/standalone.xml \
     aekrylov/webbpm-app:1.22.3
    ```
    
    This image exposes 8080 as a HTTP port and 9990 as a management port. 
    Note that these ports are specified in standalone.xml and those values are simply Wildfly defaults.
    
    Optionally: also provide a deployment using bind mount, e.g.:
    ```bash
    docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787 \
     -v $(pwd)/standalone.xml:/config/standalone.xml \
     -v $(pwd)/app.ear:/apps/app.ear \
     aekrylov/webbpm-app:1.22.3
    ```
    
2. Deploy applications using the management port, if needed

## Using an application specific image
You'll need to package your app and prepare your standalone.xml outside of Docker, see [Dockerfile-app](Dockerfile-app)

How to build and run the app: 
```bash
docker build -t zags-develop -f Dockerfile-app .
docker run -p 80:8080 -p 9990:9990 zags-develop
```

## Building a project using Docker

See [Dockerfile-builder](Dockerfile-builder)

A separate volume should be used for maven cache, to enable caching between builds, e.g. 

```docker volume create m2-cache```

Example usage: 
```bash
docker run -it --rm -v "$(pwd)":/usr/src/app -v m2-cache:/root/.m2 -w /usr/src/app aekrylov/webbpm-builder
```

## Performance concerns
**TODO**

## TODO
- [ ] Volumes for data,tmp and standalone.xml
- [ ] Easy FS based deployment
- [ ] Build using vanilla Wildfly + patches
- [ ] Build projects in Docker (if feasible)
- [ ] Ensure hotswap and debug mode are both working