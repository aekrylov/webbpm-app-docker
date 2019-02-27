#!/usr/bin/env sh

# Copy files from root for convenience. If they don't exist, don't throw or write anything
cp /apps/* standalone/deployments/ 2>/dev/null || :
cp /standalone.xml standalone/configuration/ 2>/dev/null || :

# TODO workaround for debug disabled on Linux
echo 'JAVA_OPTS="$JAVA_OPTS -agentlib:jdwp=transport=dt_socket,address=8787,server=y,suspend=n"' >> bin/standalone.conf

# Start the standalone server
bin/standalone.sh --read-only-server-config=standalone.xml