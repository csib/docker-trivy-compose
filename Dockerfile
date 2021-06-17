FROM docker:20
# Installing latest trivy good idea?
ENV TRIVY_VERSION=0.18.3

RUN apk update && apk upgrade && apk add py3-pip python3-dev libffi-dev openssl-dev curl gcc libc-dev make musl-dev openssl-dev cargo && \
    pip3 install docker-compose

RUN wget --no-verbose https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -O - | tar -zxvf - && \
    mv trivy /usr/local/bin/

RUN apk del gcc make musl-dev openssl-dev cargo