FROM alpine
MAINTAINER Evan Hazlett <ejhazlett@gmail.com>
RUN apk add -U nginx apache2-utils bash

ADD run.sh /usr/local/bin/run
ENTRYPOINT ["/usr/local/bin/run"]
EXPOSE 80
CMD []
