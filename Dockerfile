FROM alpine:3.17
LABEL maintaner="Fernando Constantino <const.fernando@gmail.com>"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="ferdn4ndo/bash-container-template"
LABEL org.label-schema.description="An Alpine-based docker image template for bash-based services, including a complete CI workflow with UTs and E2E validation."
LABEL org.label-schema.vcs-url="https://github.com/ferdn4ndo/bash-container-template"
LABEL org.label-schema.usage="/backup/README.md"
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="docker run --rm --env-file ./.env ferdn4ndo/bash-container-template"
LABEL org.label-schema.docker.cmd.devel="docker run --rm --env-file ./.env -v ./scripts:/backup/scripts ferdn4ndo/bash-container-template"
LABEL org.label-schema.docker.cmd.test="docker run --rm --env-file ./.env ferdn4ndo/bash-container-template tests.sh"

WORKDIR /scripts

RUN apk update \
    && apk add bash \
    && apk add coreutils \
    && apk update \
    && apk upgrade -f -v \
    && rm -rf /var/cache/apk/*

ADD scripts /scripts

RUN chmod +x entrypoint.sh

ENTRYPOINT ["sh", "entrypoint.sh"]
