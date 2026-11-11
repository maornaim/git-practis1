#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]
then
    echo "Need one argument"
    exit 1
fi

service="$1"
tmp=$(mktemp)

cleanup() {
    rm -f "$tmp"
}

trap cleanup EXIT

status=$(systemctl is-active "$service")
code=$?

if [[ "$status" == "active" ]]
then
    echo "Service $service is active" > "$tmp"
else
    echo "Service $service is not active" > "$tmp"

    journalctl -u "$service" -n 5 --no-pager |
        sed 's/Stopped/STOPPED/g' >> "$tmp"
fi

tee -a "ssh-audit.log" < "$tmp"

if [[ "$code" -ne 0 ]]
then
    exit 1
fi