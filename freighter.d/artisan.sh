_fcmd_artisan() {
    HELP_USG="[<any artisan command>]"
    HELP_TXT="Run artisan on the app container"
    _show_help "$@"

    _req_running

    $COMPOSE exec -u $UID $IMG_APP php artisan $@
}

_fcmd_art() {
    _fcmd_artisan "$@"
}
