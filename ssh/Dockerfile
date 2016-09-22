FROM alpine:latest
RUN apk add -U openssh bash rsync
RUN adduser -D user && mkdir -p /home/user && chown -R user:user /home/user
RUN mkdir -p /var/log && touch /var/log/btmp
COPY run.sh /bin/run
EXPOSE 22
CMD ["/bin/run"]
