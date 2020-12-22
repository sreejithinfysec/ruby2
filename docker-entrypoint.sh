#!/bin/bash

port=${PORT:-3000}
env=${ENV:-test}

DEV_SECRET=$(date | sha256sum)
sleep 1
TEST_SECRET=$(date | sha256sum)

sed -i'' -E "s/%PORT%/${port}/g" /graphql/config/puma.rb
sed -i'' -E "s/%ENV%/${env}/g" /graphql/config/puma.rb
sed -i'' -E "s/%DEV_SECRET_KEY%/${DEV_SECRET}/g" /graphql/config/secrets.yml
sed -i'' -E "s/%TEST_SECRET_KEY%/${TEST_SECRET}/g" /graphql/config/secrets.yml

export RAILS_ENV=development
rails server $@
