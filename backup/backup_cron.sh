#!/bin/bash -e

# cd to root directory of this repository
cd "$(dirname $0)/.."

backup_dir="./backup/daily"
mkdir -p "${backup_dir}"

today=$(date +%Y-%m-%d)
backup_file="$backup_dir/smr_live_$today.sql"

docker-compose exec -T mysql sh -c 'mysqldump -uroot -p$MYSQL_ROOT_PASSWORD --add-drop-table --add-locks --quote-names --databases smr_live' > ${backup_file}
bzip2 "${backup_file}"

# Delete all backups that are older than 14 days
find "${backup_dir}" -daystart -mtime +14 -delete
