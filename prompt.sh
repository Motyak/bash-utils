#!/bin/bash

[ "${BASH_SOURCE[0]}" == "$0" ] && {
    >&2 echo "this script is meant to be sourced, not executed"
    exit 1
}

function __setup_prompt {
    local DELIMIT='\[\]'
    local RESET='\e[0;0m'
    local BLACK='\e[0;90m'; END_BLACK=$RESET
    local BLUE='\e[0;34m'; END_BLUE=$RESET

    local SC='\e7' # save cursor pos
    local RC='\e8' # restore cursor pos
    local CUU1='\e[1A' # move cursor up 1 row

    function __IN_EXIT_CODE_COLOR {
        local exit_code=$?
        local colored_text=$1
        local RESET='\e[0;0m'
        local RED='\e[0;31m'; END_RED=$RESET
        local GREEN='\e[0;32m'; END_GREEN=$RESET
        if [ $exit_code -eq 0 ]; then
            printf ''${GREEN}${colored_text}${END_GREEN}
        else
            printf ''${RED}${colored_text}${END_RED}
        fi
    }

    PS1=''${DELIMIT}'[$(__IN_EXIT_CODE_COLOR '\''\A'\'')'${BLACK}'.$(date +%S%3N)'${END_BLACK}' '${BLUE}'\W'${END_BLUE}']\$ '${DELIMIT}
    PS0=''${DELIMIT}${SC}${CUU1}$(eval 'echo $PS1')${RC}${DELIMIT}
}

__setup_prompt

unset -f __setup_prompt
