FROM anapsix/alpine-java:8_jdk-dcevm

ARG APP_VERSION
ARG APP_TYPE=prod

RUN apk add -q aria2 && \
    aria2c -x 8 -s 8 -o app.zip http://artifactory.cg.ru/artifactory/simple/libs-releases-local/ru/cg/webbpm/webbpm-app-${APP_TYPE}/${APP_VERSION}/webbpm-app-${APP_TYPE}-${APP_VERSION}.zip && \
    unzip -q app.zip && \
    rm -rf webbpm-app/jre && \
    mv webbpm-app /opt/ && \
    rm app.zip && \
    apk del -q aria2

WORKDIR /opt/webbpm-app

# TODO workaround for debug disabled on Linux
RUN echo 'JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"' >> bin/standalone.conf

RUN chmod +x bin/*.sh

RUN ln -sf /opt/webbpm-app/standalone/deployments /apps
RUN ln -sf /opt/webbpm-app/standalone/configuration /config

# TODO
#VOLUME ["/opt/webbpm-app/standalone/deployments", "/opt/webbpm-app/standalone/data", "/opt/webbpm-app/standalone/tmp", "/opt/webbpm-app/standalone/configuration/standalone.xml"]

# TODO revise expose directives since ports can be changed in config file
EXPOSE 8080
EXPOSE 9990
EXPOSE 8787

ENTRYPOINT ["bin/standalone.sh", "--read-only-server-config=standalone.xml"]