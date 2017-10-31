_fcmd_list() {
    HELP_USG=""
    HELP_TXT="List all avaliable commands"
    _show_help "$@"

    echo "Available commands:"
    declare -F | grep "_fcmd_" | awk '{print $3}' | sed -e "s/^_fcmd_/  - /"
    echo ""
    echo "Help:"
    echo "  ./freighter <command> -h"
}
