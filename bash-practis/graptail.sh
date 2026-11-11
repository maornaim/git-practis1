log_file="services.log"

if grep -q "STOPPED" "$log_file"
then
    echo "warinin: servis is stoped"
else
    echo "all servises are runing"
fi