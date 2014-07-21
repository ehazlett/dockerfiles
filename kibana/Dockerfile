FROM debian:jessie
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y nginx-full wget
RUN wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O /tmp/kibana.tar.gz && \
    tar zxf /tmp/kibana.tar.gz && mv kibana-3.1.0/* /usr/share/nginx/html
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]
