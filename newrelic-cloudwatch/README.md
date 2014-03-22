# NewRelic CloudWatch
This integrates NewRelic stats with CloudWatch.

# Build

`docker build -t newrelic-cloudwatch .`

# Usage
`docker run -i -t newrelic-cloudwatch <action> [action-args]`

For example:

`docker run -i -t newrelic-cloudwatch rpm <rpm-args>`

# Checks

## RPM
This will use https://github.com/ehazlett/newrelic-rpm-check to check the Requests Per Minute for the specified NewRelic Application ID.

This will check the Application Requests Per Minute and send them to CloudWatch every minute.  You can see https://github.com/ehazlett/newrelic-rpm-check` for details.  The metric namespace is `Apps/<APP_NAME>` where `APP_NAME` has spaces stripped.

`docker run -i -t -e AWS_ACCESS_KEY_ID=<aws-access-id> -e AWS_SECRET_KEY=<aws-secret-key> newrelic-cloudwatch rpm -a <newrelic-app-id> -k <newrelic-api-key>`
