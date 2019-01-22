# webbpm-app-docker - Dockerized webbpm-app

The image is based on DCEVM-enabled JDK and webbpm-app-prod

## Building the base image
You need to specify webbpm-app version
`docker build --build-arg APP_VERSION=<webbpm-app-prod version> .`

## Running the base image
1. Mount `standalone.xml`:

    ```bash
    docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787 \
     -v $(pwd)/standalone.xml:/standalone.xml \
     aekrylov/webbpm-app:1.22.3
    ```
    
    This image exposes 8080 as a HTTP port and 9990 as a management port. 
    Note that these ports are specified in standalone.xml and those values are simply Wildfly defaults.
    
    Optionally: also provide a deployment using bind mount, e.g.:
    ```bash
    docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787 \
     -v $(pwd)/standalone.xml:/standalone.xml \
     -v $(pwd)/app.ear:/apps/app.ear \
     aekrylov/webbpm-app:1.22.3
    ```
    
2. Deploy applications using the management port, if needed

## Using an application specific image
You'll need to package your app and prepare your standalone.xml outside of Docker, see [Dockerfile-zags](./Dockerfile-zags)

How to build and run the app: 
```bash
docker build -t zags-develop -f Dockerfile-zags .
docker run -p 80:8080 -p 9990:9990 zags-develop
```

## Performance concerns
**TODO**

## TODO
- [ ] Volumes for data,tmp and standalone.xml
- [ ] Easy FS based deployment
- [ ] Build using vanilla Wildfly + patches
- [ ] Build projects in Docker (if feasible)
- [ ] Ensure hotswap and debug mode are both working