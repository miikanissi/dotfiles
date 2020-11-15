#!/bin/sh
# uses pandoc and lynx to preview markdown in terminal

pandoc $1 | lynx -stdin
