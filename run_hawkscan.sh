#!/usr/bin/env bash

port=${1:-3000}
env=${2:-test}

compose=$(which docker-compose)

if [[ -f  ${compose} ]]; then
	docker-compose build
	docker-compose up -d
else
  docker network create hawknet
	docker build -t stackhawk/vuln-graphql-ruby .
	docker run --rm --name vuln-graphql-ruby --network hawknet -td -p ${port}:${port} -e PORT=${port} -e ENV=${env} stackhawk/vuln-graphq-ruby
fi

sleep 5

source ./AUTH_TOKEN;

docker run -e AUTH_TOKEN="${token}" -e AUTH_COOKIE="${cookie}" -e SHAWK_DEBUG=true -e SHAWK_AUTH_ENDPOINT= -e APP_HOST=http://127.0.0.1:${port} --rm -v $(pwd):/hawk:rw -ti --name hawkscan --network hawknet stackhawk/hawkscan:latest

[[ $? != 0 ]] && exit 2

if [[ -f ${compose} ]]; then
	docker-compose down
	docker-compose rm
else
	docker kill vuln-graphql-ruby
	docker rm vuln-graphq-ruby
	docker network rm hawknet
fi
