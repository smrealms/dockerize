#!/bin/bash

echo "SMR version in current container (running live server):"
docker-compose exec smr cat git-commit

echo
echo "SMR version in current image (will go live on rebuild):"
docker-compose run --rm smr cat git-commit

echo
echo 'Run `docker-compose pull smr` to update the image.'
