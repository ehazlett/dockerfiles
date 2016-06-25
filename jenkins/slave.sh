#!/bin/bash
JENKINS_MANAGER=${JENKINS_MANAGER:-}
JENKINS_SLAVE_NAME=${JENKINS_SLAVE_NAME:-$HOSTNAME}
JENKINS_ROOT_PATH=${JENKINS_ROOT_PATH:-/var/tmp/jenkins}
JENKINS_EXECUTORS=${JENKINS_EXECUTORS:-4}
JENKINS_USERNAME=${JENKINS_USERNAME:-}
JENKINS_PASSWORD=${JENKINS_PASSWORD:-}

if [ -z "$JENKINS_MANAGER" ]; then
    echo "ERR: you must set the JENKINS_MANAGER env var"
    exit 1
fi

if [ -z "$JENKINS_USERNAME" ] || [ -z "$JENKINS_PASSWORD" ]; then
    echo "ERR: you must set the JENKINS_USERNAME and JENKINS_PASSWORD env vars"
    exit 1
fi

curl -sSL $JENKINS_MANAGER/jnlpJars/slave.jar -o /var/tmp/slave.jar
curl -sSL $JENKINS_MANAGER/jnlpJars/jenkins-cli.jar -o /var/tmp/cli.jar

# create node dynamically
cat <<EOF | java -jar /var/tmp/cli.jar -s $JENKINS_MANAGER create-node $JENKINS_SLAVE_NAME --username $JENKINS_USERNAME --password $JENKINS_PASSWORD
<slave>
  <name>${JENKINS_SLAVE_NAME}</name>
  <description></description>
  <remoteFS>${JENKINS_ROOT_PATH}/${JENKINS_SLAVE_NAME}</remoteFS>
  <numExecutors>${JENKINS_EXECUTORS}</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <label></label>
  <nodeProperties/>
</slave>
EOF

# start slave
java -jar /var/tmp/slave.jar -jnlpCredentials $JENKINS_USERNAME:$JENKINS_PASSWORD -jnlpUrl $JENKINS_MANAGER/computer/$JENKINS_SLAVE_NAME/slave-agent.jnlp
