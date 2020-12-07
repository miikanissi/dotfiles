#!/bin/bash
# 
# weather script for polybar (or any other bar, or just command line)
# Miika Nissi

LOCATION=Riihimäki
weather_report="${XDG_DATA_HOME:-$HOME/.local/share}/weather_report"
weather_image="${XDG_DATA_HOME:-$HOME/.local/share}/weather.png"

# function to check the weather from wttr.in, checks if invalid or empty output, ie no internet
# valid output gets sent to weather_report file
get_weather()
{
  weather=$(curl -s "wttr.in/$LOCATION?format=3&?u")
  humidity=$(curl -s wttr.in/$LOCATION?format=%h)
  if [ $(echo "$weather" | grep -E "(Unknown|curl|HTML)" | wc -l) -gt 0 ]; then
	  return 0;
  else
	  if [ -z "$weather" ]; then
	    return 0;
	  else
      # weather_icon=$(echo "$weather" | awk '{ print substr($2,1,1)}')
      echo "$weather" "$humidity" | awk '{print "%{F#c85e7c}%{T2}"$2"%{T-}%{F-} "$3" "$4}' > "$weather_report"
	    wget -q -O $weather_image wttr.in/${LOCATION}_U.png
    fi
  fi
}
get_weather
# checks the hour when weather_report was made, if the current hour is not the same it gets the weather_report
[ "$(stat -c %y "$weather_report" 2>/dev/null | cut -b'12,13')" = "$(date '+%H')" ] ||
	get_weather

# echos content of weather_report
echo $(sed '1q;d' "$weather_report")
# optionally echos the date and time when report was modified
# echo $(stat -c %y "$weather_report" 2>/dev/null | cut -b'1-16')

