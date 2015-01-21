FROM debian:jessie
RUN apt-get update && apt-get install -y znc
RUN useradd znc
USER znc
EXPOSE 6667
ENTRYPOINT ["znc"]
CMD ["exec", "znc", "-f"]
