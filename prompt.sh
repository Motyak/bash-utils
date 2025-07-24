#!/bin/bash

DELIMIT='\[\]'
RESET='\e0m'
BLACK='\e[0;30m'; END_BLACK=$RESET
RED='e[0;31m'; END_RED=$RESET
GREEN='\e[0;32m'; END_GREEN=$RESET

function __IN_EXIT_CODE_COLOR {
    local colored_text=$1
    if [ $? -eq 0 ]; then
        echo ${GREEN}${colored_text}${END_GREEN}
    else
        echo ${RED}${colored_text}${END_RED}
    fi
}

PS1=''${DELIMIT}'[$(__IN_EXIT_CODE_COLOR '\''\A'\'')'${BLACK}'.$(date +%S%3N)'${END_BLACK}' \W]\$ '${DELIMIT}


