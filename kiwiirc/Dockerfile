FROM node:0.11-slim
RUN apt-get update && apt-get install -y git-core
RUN git clone https://github.com/prawnsalad/KiwiIRC.git /kiwi
RUN (cd /kiwi && npm install && cp config.example.js config.js)
RUN (cd /kiwi && ./kiwi build)
WORKDIR /kiwi
EXPOSE 7778
CMD ["./kiwi", "-f", "start"]
