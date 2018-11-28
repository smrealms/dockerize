#!/usr/bin/env bash

set -exo pipefail

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)"
backup_dir="${base_dir}/daily"
data_dir="${base_dir}/../data/db"

# Find the youngest backup file in the backup dir
backup_file="$(ls -1t "${backup_dir}" | head -n 1)"

# Unzip it to a directory that mysql container has access to
bzcat --keep "${backup_dir}/${backup_file}" > "${data_dir}/dump.sql"

# Write mysql credentials in the container to avoid
# mysql: [Warning] Using a password on the command line interface can be insecure.
docker-compose exec -T mysql sh -c 'echo "[client]\nhost=localhost\nuser=root\npassword=$MYSQL_ROOT_PASSWORD" > ${HOME}/.my.cnf'

# Import the dump
docker-compose exec -T mysql sh -c 'mysql < /var/lib/mysql/dump.sql'

rm -f "${data_dir}/dump.sql"
