#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]
then
    echo "Need one directory"
    exit 1
fi

path="$1"

if [[ ! -d "$path" ]]
then
    echo "Directory not found"
    exit 1
fi

tmp=$(mktemp)

cleanup() {
    rm -f "$tmp"
}

trap cleanup EXIT

check() {
    echo "Directory size:"
    du -sh "$path"

    echo "Disk space"
    df -h "$path"

    echo "ram now: "
    free -h 
}

check >> $tmp
cat "$tmp" | tee -a "system.lloggs"