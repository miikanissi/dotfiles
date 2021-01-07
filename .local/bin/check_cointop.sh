#!/bin/sh
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# sends notification of current crypto holdings

parsed=$(cointop holdings -d -s price --format json | jq -j '.[] | .symbol, " ", .price, "\n"')
notify-send "$parsed"
