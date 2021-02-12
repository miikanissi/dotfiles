#!/bin/bash
#
# weather script for polybar from wttr.in
# by Miika Nissi https://miikanissi.com

[ -z "$LOCATION" ] && LOCATION="Riihimäki"
weather_report="${XDG_DATA_HOME:-$HOME/.local/share}/weather_report"
weather_oneline="${XDG_DATA_HOME:-$HOME/.local/share}/weather_oneline"

get_weather() {
  # curl wttr.in format options: %c = condition icon, %t = temperature, %h = humidity, ?u = USCS units
  wttr=$(curl -s "v2d.wttr.in/$LOCATION?format=%c+%t+%h&?u")
  # exit if unable to get wttr
  [ $(echo "$wttr" | grep -E "(Unknown|curl|HTML)" | wc -l) -gt 0 ] || [ -z "$wttr" ] && return 0;
  # awk to format polybar colors
  # echo $wttr | awk '{print "%{F#d65d0e}"$1"%{F-} "$2" "$3}' > "$weather_oneline"
  echo $wttr | awk '{print $2}' > "$weather_oneline"
  curl -s "v2d.wttr.in/$LOCATION" > "$weather_report"

}

[ -f "$weather_oneline" ] || get_weather
# updates weather after an hour has passed
[ $(("$(date '+%s')"-"$(stat -c %Y "$weather_oneline")")) -ge 3600 ] && get_weather

# echos oneline content from file
echo $(sed '1q;d' "$weather_oneline")
