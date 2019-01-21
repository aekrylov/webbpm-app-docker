#!/usr/bin/env sh

# Copy files from root for convenience. If they don't exist, don't throw or write anything
cp /apps/* standalone/deployments/ 2>/dev/null || :
cp /standalone.xml standalone/configuration/ 2>/dev/null || :

# Start the standalone server
bin/standalone.sh --read-only-server-config=standalone.xml