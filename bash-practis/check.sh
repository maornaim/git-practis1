servise=("ssh" "nginx" "docker")

check(){
    for ser in "${servise[@]}"
    do 
        if systemctl  is-active --quiet "$ser" 
        then
           echo "$ser is RUNNING" | tee -a services.log
           
        else    
          echo "$ser is STOPPED" | tee -a services.log
        fi
    done

}

check


