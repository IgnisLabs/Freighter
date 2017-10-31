_fcmd_shell() {
    HELP_USG="<container>"
    HELP_TXT="Drop to a bash shell inside <container>."
    HELP_TXT="$HELP_TXT\nYou can specify which shell to use with the F_SHELL env var."
    _show_help --no-args "$@"

    _req_running

    F_SHELL=${F_SHELL:-"bash"}
    $COMPOSE exec $1 $F_SHELL
}

_fcmd_sh() {
    _fcmd_shell "$@"
}
