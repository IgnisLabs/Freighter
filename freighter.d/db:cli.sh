_fcmd_db:console() {
    HELP_USG=""
    HELP_TXT="Access the MySQL Command-Line Tool on the $IMG_MYSQL container"
    _show_help "$@"

    _req_running

    $COMPOSE exec "$IMG_MYSQL" mysql -u root -p"$DB_PASSWORD" -D "$DB_DATABASE"
}

_fcmd_db:clt() {
    _fcmd_db:console "$@"
}
