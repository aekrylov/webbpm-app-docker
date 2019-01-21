FROM anapsix/alpine-java:8_jdk-dcevm

ARG APP_VERSION

RUN apk add -q aria2 && \
    aria2c -x 8 -s 8 -o app.zip http://artifactory.cg.ru/artifactory/simple/libs-releases-local/ru/cg/webbpm/webbpm-app-prod/${APP_VERSION}/webbpm-app-prod-${APP_VERSION}.zip && \
    unzip -q app.zip && \
    mv webbpm-app /opt/ && \
    rm app.zip && \
    apk del -q aria2

WORKDIR /opt/webbpm-app
RUN rm -f standalone/configuration/standalone*.xml
RUN chmod +x bin/*.sh

# TODO
#VOLUME ["/opt/webbpm-app/standalone/deployments", "/opt/webbpm-app/standalone/data", "/opt/webbpm-app/standalone/tmp", "/opt/webbpm-app/standalone/configuration/standalone.xml"]

# TODO revise expose directives since ports can be changed in config file
EXPOSE 8080
EXPOSE 9990
EXPOSE 8787

CMD ["bin/standalone.sh", "--read-only-server-config=standalone.xml"]