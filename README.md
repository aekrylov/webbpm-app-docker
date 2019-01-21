# webbpm-app-docker - Dockerized webbpm-app

The image is based on DCEVM-enabled JDK and webbpm-app-prod

## How to build

You need to specify webbpm-app version
`docker build --build-arg APP_VERSION=<webbpm-app-prod version> .`

## How to run

Mount `standalone.xml`:

```bash
docker run -p 8080:8080 -p 9990:9990 \
 -v $(pwd)/standalone.xml:/opt/webbpm-app/standalone/configuration/standalone.xml \
 aekrylov/webbpm-app:1.22.3
```

The images exposes 8080 as a HTTP port and 9990 as a management port. Note that these ports are specified in standalone.xml
and those values are simply Wildfly defaults.