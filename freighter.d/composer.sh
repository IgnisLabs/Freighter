_fcmd_composer() {
    HELP_USG="[<composer commands>]"
    HELP_TXT="Run composer on the app container"
    _show_help "$@"

    _req_running

    $COMPOSE exec -u $UID $IMG_APP composer $@
}

_fcmd_c() {
    _fcmd_composer "$@"
}
