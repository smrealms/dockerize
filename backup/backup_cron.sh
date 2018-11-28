#!/bin/bash -e

# cd to root directory of this repository
cd "$(dirname $0)/.."

backup_dir="./backup/daily"
mkdir -p "${backup_dir}"

today=$(date +%Y-%m-%d)
backup_file="$backup_dir/smr_live_$today.sql"

# Write mysql credentials in the container to avoid
# mysql: [Warning] Using a password on the command line interface can be insecure.
docker-compose exec -T mysql sh -c 'echo "[client]\nhost=localhost\nuser=root\npassword=$MYSQL_ROOT_PASSWORD" > ${HOME}/.my.cnf'

docker-compose exec -T mysql sh -c 'mysqldump --add-drop-table --add-locks --quote-names --databases smr_live' > ${backup_file}
bzip2 "${backup_file}"

# Delete all backups that are older than 14 days
find "${backup_dir}" -daystart -mtime +14 -delete
