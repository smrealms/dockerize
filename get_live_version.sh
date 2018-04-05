#!/bin/bash

# Print the version of the smr code running on the live server
docker-compose run --rm smr cat git-commit
