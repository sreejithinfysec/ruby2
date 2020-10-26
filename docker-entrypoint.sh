#!/bin/bash

[[ -z ${SERVER_PORT} ]] && p=3000 || p=${SERVER_PORT}

[[ -z ${1} ]] && port=${p} || port=${1}

[[ -z ${ENV} ]] && e=test || e=${ENV}

[[ -z ${2} ]] && env=${e} || env=${2}

sed -i'' -E "s/%SERVER_PORT%/${port}/g" /graphql/config/puma.rb
sed -i'' -E "s/%ENV%/${env}/g" /graphql/config/puma.rb

rails server $@
