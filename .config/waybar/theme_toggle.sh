#!/usr/bin/env bash

for arg in "$@"; do
    if [ "$arg" == "-d" ]; then
        ~/.local/bin/toggle-theme.sh -d >/dev/null
    elif [ "$arg" == "-l" ]; then
        ~/.local/bin/toggle-theme.sh -l >/dev/null
    elif [ "$arg" == "-t" ]; then
        ~/.local/bin/toggle-theme.sh -t >/dev/null
    fi
done

# Query current theme
if grep -q '^!! BEGIN DARK$' ~/.Xresources; then
    # Light mode active
    echo '{"alt":"light", "class":"light", "tooltip":"Theme: Light"}'
else
    # Dark mode active
    echo '{"alt":"dark", "class":"dark", "tooltip":"Theme: Dark"}'
fi
