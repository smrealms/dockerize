#!/usr/bin/env bash

set -eo pipefail

base_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null && pwd)"
cd "${base_dir}" || exit

backup_dir="${base_dir}/backup/daily"

# Find the youngest backup file in the backup dir
backup_file="$(ls -1t "${backup_dir}" | head -n 1)"

if [[ -z "${backup_file}" ]]; then
    echo "Unable to find a valid backup file. Check ${backup_dir}"
    exit 1
fi

echo "Import '${backup_file}' into database..."

# Unzip it to a directory that mysql container has access to
bzcat --keep "${backup_dir}/${backup_file}" > "${data_dir}/dump.sql"

# Write mysql credentials in the container to avoid
# mysql: [Warning] Using a password on the command line interface can be insecure.
docker-compose exec -T mysql sh -c 'echo "[client]\nhost=localhost\nuser=root\npassword=$MYSQL_ROOT_PASSWORD" > ${HOME}/.my.cnf'

# Unzip dump and import on the fly
bzcat --keep "${backup_dir}/${backup_file}" | docker exec -i smr-mysql mysql
