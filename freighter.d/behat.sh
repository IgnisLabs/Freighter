_fcmd_behat() {
    HELP_USG="[<behat commands>]"
    HELP_TXT="Run behat on the app container"
    _show_help "$@"

    _req_running

    $COMPOSE exec -u $UID $IMG_APP vendor/bin/behat $@
}

_fcmd_bh() {
    _fcmd_behat "$@"
}
