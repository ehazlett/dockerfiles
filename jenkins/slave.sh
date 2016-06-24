#!/bin/bash
JENKINS_MANAGER=${JENKINS_MANAGER:-}
JENKINS_SLAVE_NAME=${JENKINS_SLAVE_NAME:-$HOSTNAME}
JENKINS_SECRET=${JENKINS_SECRET:-}

if [ -z "$JENKINS_MANAGER" ]; then
    echo "ERR: you must set the JENKINS_MANAGER env var"
    exit 1
fi

if [ -z "$JENKINS_SECRET" ]; then
    echo "ERR: you must set the JENKINS_SECRET env var"
    exit 1
fi

curl -sSL $JENKINS_MANAGER/jnlpJars/slave.jar/ -o /var/tmp/slave.jar

java -jar /var/tmp/slave.jar -jnlpUrl $JENKINS_MANAGER/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp -secret $JENKINS_SECRET
