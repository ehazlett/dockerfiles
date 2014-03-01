from stackbrew/debian:jessie
maintainer Evan Hazlett <ejhazlett@gmail.com> @ehazlett
run apt-get update -qq
run apt-get install -qq -y ca-certificates wget unzip openjdk-6-jre-headless
run wget -q http://ec2-downloads.s3.amazonaws.com/CloudWatch-2010-08-01.zip -O /tmp/tools.zip
run (cd /opt ; unzip /tmp/tools.zip)
run (cd /opt ; mv CloudWatch-* cloudwatch)
run (cd /tmp ; wget -q https://github.com/ehazlett/newrelic-rpm-check/releases/download/v0.0.2/newrelic-rpm-check_linux64.zip ; cd /usr/local/bin ; unzip /tmp/newrelic-rpm-check_linux64.zip ; chmod +x /usr/local/bin/newrelic-rpm-check)
env AWS_CLOUDWATCH_HOME /opt/cloudwatch
env JAVA_HOME usr/lib/jvm/java-6-openjdk-amd64
env PATH $PATH:/opt/cloudwatch/bin
add run.sh /usr/local/bin/run
entrypoint ["/usr/local/bin/run"]
