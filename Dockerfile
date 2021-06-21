ARG DOCKER_VERSION=20
FROM docker:${DOCKER_VERSION}

# Installing latest trivy good idea?
ENV TRIVY_VERSION=0.18.3

RUN apk add --no-cache py3-pip

RUN apk add --no-cache --virtual build-dependencies python3-dev libffi-dev openssl-dev curl gcc libc-dev make musl-dev openssl-dev cargo && \
    pip3 install docker-compose && apk del build-dependencies

RUN wget --no-verbose https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -O - | tar -zxvf - && \
    mv trivy /usr/local/bin/

RUN apk update && apk upgrade

LABEL \
  org.opencontainers.image.authors="Áron Csaba <csibtsib@gmail.com>" \
  org.opencontainers.image.description="This docker image installs docker-compose and trivy on top of the docker image." \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.source="https://github.com/csib/docker-trivy-compose" \
  org.opencontainers.image.title="Docker Compose and Trivy on docker base image" \
  org.opencontainers.image.vendor="csib" \
  org.opencontainers.image.version="${DOCKER_VERSION} with docker-compose and Trivy ${TRIVY_VERSION}"