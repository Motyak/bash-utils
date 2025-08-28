#!/bin/bash

[ "${BASH_SOURCE[0]}" == "$0" ] && {
    >&2 echo "script must be sourced in current shell, not executed in a new shell"
    exit 1
}

mkdir "$1" 2>/dev/null || \
mkdir "$1${1:+_}$(date +%Y)" 2>/dev/null || \
mkdir "$1${1:+_}$(date +%Y%m)" 2>/dev/null || \
mkdir "$1${1:+_}$(date +%Y%m%d)" 2>/dev/null || \
mkdir "$1${1:+_}$(date +%Y%m%d_%Hh%Mm%Ss)" 2>/dev/null
cd "$_"
