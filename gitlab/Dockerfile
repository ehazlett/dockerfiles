FROM gitlab/gitlab-ce
RUN curl -o /usr/local/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-latest && \
    chmod +x /usr/local/bin/docker &&  \
    wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64 && \
    chmod +x /usr/local/bin/gitlab-ci-multi-runner
