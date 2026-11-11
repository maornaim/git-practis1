url="https://example.com"

if curl -I "$url"
then
    echo "service is avilebal"
else
    echo "service isn't avilebal"
fi