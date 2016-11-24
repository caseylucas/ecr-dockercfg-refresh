FROM alpine

MAINTAINER caseylucas <caseylucas@gmail.com>

ADD https://storage.googleapis.com/kubernetes-release/release/v1.4.6/bin/linux/amd64/kubectl /usr/local/bin/
COPY ecr-dockercfg-refresh.sh /usr/local/bin/

RUN set -x && \
    apk add --no-cache \
        curl \
        ca-certificates \
        python \
        py-pip && \
    pip install awscli && \
    chmod +x /usr/local/bin/kubectl /usr/local/bin/ecr-dockercfg-refresh.sh

# See script for env that can drive execution. Ex: To only run once set REFRESH_INTERVAL=0
# ENV REFRESH_INTERVAL=0

CMD "/usr/local/bin/ecr-dockercfg-refresh.sh"

