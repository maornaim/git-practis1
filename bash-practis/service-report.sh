#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]
then
    echo "need one system"
    exit 1
fi
system="$1"

func(){
    echo ""$system" is:" 
    systemctl is-active "$system"

    journalctl -u "$system" --no-pager | tail -n 2 



}
func