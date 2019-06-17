#!/bin/bash

function wait_for_server() {
  until `$JBOSS_HOME/bin/jboss-cli.sh -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
    sleep 1
  done
}

set -e
echo "starting JBoss"
nohup $JBOSS_HOME/bin/standalone.sh &
wait_for_server

find patches -type f -name '*.cli' -exec $JBOSS_HOME/bin/jboss-cli.sh --connect --file={} \;

echo "stopping JBoss"
$JBOSS_HOME/bin/jboss-cli.sh --connect --command=:shutdown
