if pgrep wlsunset >/dev/null; then
    killall wlsunset
fi

RETRIES=30
counter=0
while true; do
    CONTENT=$(curl -s http://ip-api.com/json/)
    if [ $? -eq 0 ]; then
        break
    fi
    counter=$((counter + 1))
    if [ $counter -eq $RETRIES ]; then
        notify-send wlsunset.sh "Unable to connect to ip-api."
        break
    fi
    sleep 2
done
longitude=$(echo "$CONTENT" | jq .lon)
latitude=$(echo "$CONTENT" | jq .lat)
wlsunset -l "$latitude" -L "$longitude" >/dev/null 2>&1 &
