_fcmd_phpspec() {
    HELP_USG="[<phpspec commands>]"
    HELP_TXT="Run phpspec on the app container"
    _show_help "$@"

    _req_running

    $COMPOSE exec -u $UID $IMG_APP vendor/bin/phpspec $@
}

_fcmd_spec() {
    _fcmd_phpspec "$@"
}
