FROM jboss/wildfly:14.0.1.Final

WORKDIR $JBOSS_HOME

COPY patches .
COPY run-patches.sh .

RUN ./run-patches.sh
RUN rm -rf patches

# Enable debug mode TODO maybe move to patches
RUN echo 'JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"' >> bin/standalone.conf

HEALTHCHECK --timeout=3s --start-period=3600s CMD curl -f http://localhost/ || exit 1

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "--read-only-server-config=standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
