#!/usr/bin/env bash

docker-compose --help >/dev/null
COMPOSE=$?
if [[ ${COMPOSE} == 0 ]]; then
	APP_CMD="docker-compose up --build -d" 
else
	APP_CMD="docker network create hawknet && \
		docker build -t stackhawk/vuln-graphql-ruby . && \
		docker run --network hawknet --rm --name gql-ruby -td -p 3000:3000 stackhawk/vuln-graphql-ruby"
fi

# Run vuln-graphql-ruby
${APP_CMD}

sleep 5

chmod o+rw $(pwd)
HAWKSCAN_CMD="docker run \
  -e SHAWK_DEBUG=true \
  -e SHAWK_AUTH_ENDPOINT= \
  -e APP_HOST=http://${APP_HOST}:9000 \
  --rm \
  -v $(pwd):/hawk:rw \
  -t \
  --name hawkscan \
  --network hawknet \

  stackhawk/hawkscan:latest"

echo ${HAWKSCAN_CMD}

${HAWKSCAN_CMD}

x=$?
if [[ ${x} != 0 ]]; then
  [[ -e ${COMPOSE} ]] && docker-compose kill && docker-compose rm || docker kill gql-ruby 
  exit ${x}
fi

[[ -e ${COMPOSE} ]] && docker-compose kill && docker-compose rm || docker kill gql-ruby 

