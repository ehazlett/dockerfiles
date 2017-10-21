FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx && \
    rm -rf /var/lib/apt/cache
COPY nginx.conf /etc/nginx/nginx.conf
COPY run.sh /usr/local/bin/run.sh
EXPOSE 80
CMD ["/usr/local/bin/run.sh"]
