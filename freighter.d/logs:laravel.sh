_fcmd_logs:laravel() {
    HELP_USG="[<logfile>]"
    HELP_TXT="Tail laravel logs."
    HELP_TXT="$HELP_TXT\n<logfile> defaults to \"laravel\"."
    _show_help "$@"

    _req_running

    logfile=${1:-"laravel"}

    $COMPOSE exec -u $UID $IMG_APP tail -f /var/www/html/storage/logs/$logfile.log
}
