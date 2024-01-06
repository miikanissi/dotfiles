#!/bin/sh
# by Miika Nissi, https://miikanissi.com, https://github.com/miikanissi
# displays crypto holdings

total=$(printf '%.*f\n' 0 "$(cointop holdings -t)")
echo "$total"
