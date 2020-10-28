#!/bin/bash

rsync -uvrP --delete-after ~/code /media/miika/aa3a439b-1505-46e6-aeff-3fc54d55809a/rsync
rsync -uvrP --delete-after ~/docs /media/miika/aa3a439b-1505-46e6-aeff-3fc54d55809a/rsync
rsync -uvrP --delete-after ~/.config /media/miika/aa3a439b-1505-46e6-aeff-3fc54d55809a/rsync
