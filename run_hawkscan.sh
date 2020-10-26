#!/usr/bin/env bash
compose=$(which docker-compose)
[[ -f  ${compose} ]] && docker-compose up -d || docker run --rm --name graphql-ruby -td -p 3000:3000 -e PORT=3000 -e ENV=test stackhawk/graphql-ruby
sleep 5
source ./AUTH_TOKEN; 
docker run -e AUTH_TOKEN="${token}" -e AUTH_COOKIE="${cookie}" -e SHAWK_DEBUG=true -e SHAWK_AUTH_ENDPOINT= -e APP_HOST=http://127.0.0.1:3000 --rm -v $(pwd):/hawk:rw -ti --name hawkscan --network hawknet stackhawk/hawkscan:latest
[[ -f  ${compose} ]] && docker-compose down && docker-compose rm || docker kill graphql-ruby
