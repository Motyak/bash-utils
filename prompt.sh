#!/bin/bash

# Current issue:
# When a multi-line command is typed (with trailing `\`)
# then the evaluation of PS0 overwrites the wrong line
# (to fix, we should count the number of lines everytime
# $PS2 is evaluated, and then move the cursor N lines above
# in the evaluation of $PS0)

[ "${BASH_SOURCE[0]}" == "$0" ] && {
    >&2 echo "this script is meant to be sourced, not executed"
    exit 1
}

function __setup_prompt {
    local RESET='\e[0;0m'
    local BLACK='\e[0;90m'
    local BLUE='\e[0;34m'

    local SC='\e7' # save cursor pos
    local RC='\e8' # restore cursor pos
    local CUU1='\e[1A' # move cursor up 1 row

    function __EXIT_CODE_COLOR {
        local exit_code=$?
        local RED='\e[0;31m'
        local GREEN='\e[0;32m'
        if [ $exit_code -eq 0 ]; then
            echo -e ${GREEN}
        else
            echo -e ${RED}
        fi
    }

    PS1='[\[$(__EXIT_CODE_COLOR)\]\A\['${BLACK}'\].$(date +%S%3N) \['${BLUE}'\]\W\['${RESET}'\]]\$ '
    PS0=''${SC}${CUU1}$(eval 'echo $PS1')${RC}
}

__setup_prompt

unset -f __setup_prompt
