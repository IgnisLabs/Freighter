_fcmd_up() {
    HELP_USG="[<other docker-compose up args>]"
    HELP_TXT="Start your docker environment in the foreground"
    _show_help "$@"

    $COMPOSE up "$@"
}

_fcmd_start() {
    HELP_USG="[<other docker-compose up args>]"
    HELP_TXT="Start your docker environment in detached mode"
    HELP_TXT="$HELP_TXT\nYou'll have to run <down> manually to stop running containers"
    _show_help "$@"

    $COMPOSE up -d "$@"
}

_fcmd_down() {
    HELP_USG=""
    HELP_TXT="Stop your docker environment"
    _show_help "$@"

    $COMPOSE down "$@"
}
