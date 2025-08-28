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

    function __MV_CUR_UP {
        local backup_exitcode=$?
        local prompt_line_pos
        if [ "$__PS2_COUNT" -gt 0 ]; then
            prompt_line_pos="$((__PS2_COUNT + 1))"
        else
            local prompt_len
            if [ "$PWD" == "$HOME" ]; then
                prompt_len="17" # 16 + `~`
            else
                prompt_len="$((15 + $(basename "$PWD" | wc -c)))"
            fi
            local last_cmd_len; last_cmd_len="$(($(fc -ln -1 | sed 's/^[ \t]*//' | wc -c) - 1))"
            # `- 1` here because the cursor moves to a newline..
            #                     ..when the row is filled ~~v
            prompt_line_pos="$(((prompt_len + last_cmd_len - 1) / $(tput cols) + 1))"
        fi
        echo -e '\e['${prompt_line_pos}'A'
        return $backup_exitcode
    }

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

    PS2='$((__PS2_COUNT += 1))\r> '
    PS1='[\[$(__EXIT_CODE_COLOR)\]\A\['${BLACK}'\].$(printf %05d $((10#$(date +%S%3N)-5))) \['${BLUE}'\]\W\['${RESET}'\]]\$ '
    PS0=''${SC}'$(__MV_CUR_UP)$((__PS2_COUNT = 0))\r[\[$(__EXIT_CODE_COLOR)\]\A\['${BLACK}'\].$(date +%S%3N) \['${BLUE}'\]\W\['${RESET}'\]]\$ '${RC}
}

__setup_prompt

unset -f __setup_prompt
