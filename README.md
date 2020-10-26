# vuln-graphql-ruby
Ruby GraphQL target with HawkScan integration

## Introduction

[Ruby GraphQL source](https://github.com/howtographql/graphql-ruby) 

Build and test a Ruby-based GraphQL server with [HawkScan](https://hub.docker.com/r/stackhawk/hawkscan). GraphQL listens on `3000` by default. 

## Quick Start

To build, run and scan the app with HawkScan:

```bash
# run_hawkscan.sh [port] [env]
``` 

## Build

Works with either docker-compose or docker cli.

To build `vuln-graphql-ruby`:
```bash
# docker-compose build

...or

# docker build -t stackhawk/vuln-graphql-api .
``` 

## Run

To start `vuln-graphql-ruby`:

```bash
# docker-compose up 

...or

# docker run --name vuln-graphql-ruby --rm -ti -p 3000:3000 -e PORT=3000 -e ENV=test stackhawk/vuln-graphql-ruby 
```

## Scan

Once the `vuln-graphql-ruby` container is up:

```bash
# source ./AUTH_TOKEN && \
    docker run -e AUTH_TOKEN="${token}" \
        -e AUTH_COOKIE="${cookie}" \
        -e SHAWK_DEBUG=true \
        -e SHAWK_AUTH_ENDPOINT= \
        -e APP_HOST=http://127.0.0.1:3000 \
        --rm \
        -v $(pwd):/hawk:rw \
        -ti \
        --name hawkscan \
        --network hawknet \
        stackhawk/hawkscan:latest
```
