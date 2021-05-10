FROM ruby:2.6.7-slim-stretch
ARG PACKAGES="build-essential libpq-dev curl git"
RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y $PACKAGES && \
    mkdir -p /ptz-camp/tmp && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    apt-get autoremove -y && \
    apt-get clean

COPY ./docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh

WORKDIR /ptz-camp

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle \
    YARN_CACHE_FOLDER=/yarn_cache
ENV PATH="$BUNDLE_BIN:$PATH"

RUN gem install bundler -v 2.2.16

ENTRYPOINT ["/docker-entrypoint.sh"]
