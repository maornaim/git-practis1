#!/usr/bin/env bash

if [[ "$#" -ne 1 ]]
then
    echo "Need one file"
    exit 1
fi
file="$1"
if [[ ! -f "$file" ]]
then
    echo ""$file" is not a file"
    exit 1
fi

log="logs.file"

system_report(){
    
    echo "disk usge for "$1"" | tee -a "$log"
    du -sh "$1" | tee -a "$log"

    echo "disk df for "$1"" | tee -a "$log"
    df -h "$1" | tee -a "$log"

    echo "File details:" | tee -a "$log"
    ls -l "$1" | tee -a "$log"
    
    echo "File type:" | tee -a "$log"
    file "$1" | tee -a "$log"

}
system_report "$file"