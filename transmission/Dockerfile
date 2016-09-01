FROM alpine
RUN apk add -U --no-cache transmission-cli transmission-daemon
COPY run.sh /bin/run
EXPOSE 9091
CMD ["/bin/run"]
