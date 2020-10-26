FROM ruby:2.6.5-slim

ARG port=3000
ARG env=test

RUN apt update && apt upgrade -y
RUN apt install --no-install-recommends -y \
	git \
	sqlite3 \
	ruby-sqlite3 \
	bash \
	vim \
	less \
	build-essential \
	libsqlite3-dev

COPY ./ /graphql

WORKDIR /graphql

ENV SERVER_PORT $port

ENV ENV $env

EXPOSE $SERVER_PORT

RUN bundle install

RUN rails db:setup

COPY docker-entrypoint.sh /usr/local/bin

RUN chmod 0755 /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["bash", "-c", "docker-entrypoint.sh"]
