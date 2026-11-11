#!/usr/bin/env bash

log="monitoring.logs"

check_servis(){

    status=$(systemctl is-active "$1")

    echo "Service "$1" status: $status"

    if [[ "$status" == "active" ]]
    then  
        echo "servis $1 is active" >> "$log"
    else
        echo "$1 isn't active" >> "$log"
    fi

}
check_servis ssh
check_servis corn




