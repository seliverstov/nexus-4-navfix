#!/bin/bash

# Nexus 4 navigation buttons fix
#
# Author: Grigoriy Kraynov (github@gkraynov.com)
# (c) 2015
# License: MIT

if ./gettools.sh && ./pull.sh && ./patch.sh; then
    echo "Flash UPDATE.zip using custom recovery e.g. ClockWorkMod via sideload"
    echo "Don't forget to flash UPDATE_ROLLBACK.zip before accepting OTA update!"

    rm -rf stock
fi
