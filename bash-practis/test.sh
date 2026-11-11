read -p "Enter server name: " server
check_cpu(){
    if [ "$1" -gt 80 ] 
    then 
       echo "Server: $server | CPU: $1% | WARNING"
    else
        echo "Server: $server | CPU: $1% | OK"
    fi
}
cpu_values=(30 65 90 45 95)

for num in "${cpu_values[@]}"
    do
    check_cpu "$num" | tee -a monitor.txt
done

