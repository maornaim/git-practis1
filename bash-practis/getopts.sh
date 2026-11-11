#!/usr/bin/env bash
service=""
action=""

while getopts "s:a:" option
do 
    case "$option" in
        s)
            service="$OPTARG"
            ;;
        a)
            action="$OPTARG"
            ;;    
        *)
            echo "need s:service and a:action"
            exit 1
            ;;
    esac
done


if [[ -z "$action" || -z "$service" ]]
then    
    echo "need -a action and -s service"
    exit 1
fi


case "$action" in    
    start)
        sudo systemctl start "$service"
        ;;
    status)
        sudo systemctl status "$service" --no-pager
        ;;
    stop)
        sudo systemctl stop "$service" 
        ;;   
    restart)
        sudo systemctl restart "$service"
        ;;
    logs)
        journalctl -u "$service"
        ;;
    *)
        echo "Unknown action: $action"
        exit 1
        ;;
    *)
        echo "Unknown action: $action"
        exit 1
        ;;
esac
