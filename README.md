# vuln-graphql-ruby
Ruby GraphQL target with HawkScan integration

## Introduction

[Ruby GraphQL source](https://github.com/howtographql/graphql-ruby) 

Build and test a Ruby-based GraphQL server with [HawkScan](https://hub.docker.com/r/stackhawk/hawkscan). GraphQL listens on `3000` by default. 

## Quick Start

To build, run and scan the app with HawkScan:

```bash
# run_hawkscan.sh
``` 

## Build

Works with either docker-compose or docker cli.

To build `stackhawk/vuln-graphql-ruby`:
```bash
# docker-compose build

...or

# docker build -t stackhawk/vuln-graphql-api .
``` 

## Run

To start `gql-ruby`:

```bash
# docker-compose up 

...or

# docker run --name gql-ruby --rm -ti -p 3000:3000 stackhawk/vuln-graphql-ruby 
```

## Scan

Once the `gql-ruby` container is up:

```bash
# source ./AUTH_TOKEN && \
    docker run -e APP_HOST=http://127.0.0.1:3000 \
        --rm \
        -v $(pwd):/hawk:rw \
        -ti \
        --name hawkscan \
        stackhawk/hawkscan:latest example-stackhawk-config.yml
```
