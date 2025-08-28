#!/bin/bash

[ "${BASH_SOURCE[0]}" == "$0" ] && {
    >&2 echo "script must be sourced in current shell, not executed in a new shell"
    exit 1
}
[ "$1" == "" ] && {
    >&2 echo "script requires a command to resolve passed as argument"
    return 1
}
[ "$(type -t "$1")" == "" ] && {
    whereis "$1"
    return 0
}
echo "ORDER OF LOCATIONS:"
type -a "$1" | perl -ne 'print unless $_ =~ /^[\s{}]|\(/'
echo
echo "USED LOCATION:"
type "$1"
[ "$(type -t "$1")" == file ] && readlink -f "$(type -P "$1")"

return 0
