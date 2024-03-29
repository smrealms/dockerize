#!/bin/bash

echo "SMR version in current container (running live server):"
docker compose exec smr cat git-commit

echo
echo "SMR version in latest image (will go live on rebuild):"
docker run --rm smrealms/smr:web cat git-commit

echo
echo 'Run `docker compose up -d smr` to update the live server.'
echo 'Run `docker compose pull smr` to update the image.'
