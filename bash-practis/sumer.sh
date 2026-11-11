#!/usr/bin/env bash

set -euo pipefail

action=""
service=""
path=""

while getopts "a:s:p:" option
do
    case "$option" in
        a)
            action="$OPTARG"
            ;;
        s)
            service="$OPTARG"
            ;;
        p)
            path="$OPTARG"
            ;;
        *)
            echo "Usage: $0 -a ACTION [-s SERVICE] [-p PATH]"
            exit 1
            ;;
    esac
done

tmp=$(mktemp)

cleanup() {
    rm -f "$tmp"
}

trap cleanup EXIT

case "$action" in
    system)
        if [[ -z "$path" || ! -d "$path" ]]
        then
            echo "The -p option must contain a directory"
            exit 1
        fi

        system_report() {
            echo "Directory size:"
            du -sh "$path"

            echo "Disk space:"
            df -h "$path"

            echo "Memory:"
            free -h
        }

        system_report > "$tmp"
        ;;

    status)
        if [[ -z "$service" ]]
        then
            echo "The -s option must contain a service"
            exit 1
        fi

        if status=$(systemctl is-active "$service")
        then
            echo "Service $service is $status" > "$tmp"
        else
            echo "Service $service is $status" > "$tmp"
        fi
        ;;

    logs)
        if [[ -z "$service" ]]
        then
            echo "The -s option must contain a service"
            exit 1
        fi

        journalctl -u "$service" -n 10 --no-pager |
            sed 's/Stopped/STOPPED/g' > "$tmp"
        ;;

    *)
        echo "Unknown action: $action"
        echo "Use: system, status, or logs"
        exit 1
        ;;
esac

tee -a "summary.log" < "$tmp"
#push try
