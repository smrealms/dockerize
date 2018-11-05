#!/bin/bash -e

# This script should only be used for the initial install of
# the SSL certificates with certbot and nginx.
docker-compose up --build -d nginx-certbot-install
docker-compose run --rm certbot
docker-compose stop nginx-certbot-install
