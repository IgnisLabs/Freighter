_fcmd_db:dump() {
    HELP_USG="[file]"
    HELP_TXT="Run mysqldump on the $IMG_MYSQL container"
    _show_help "$@"

    _req_running

    dump=$($COMPOSE exec "$IMG_MYSQL" mysqldump -u root -p"$DB_PASSWORD" "$DB_DATABASE" | grep -v "mysqldump: \[Warning\]")

    if [ ! -z "$1" ]; then
        echo "$dump" > "$1"
        echo "Dump saved to [$1]"
    else
        echo "$dump"
    fi
}
