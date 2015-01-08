#!/bin/bash
MINVER="1."$1
JAVA=`type -p java`

if [[ "$JAVA" ]]; then
    VERSION=$($JAVA -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ $VERSION > $MINVER ]]; then
        echo $JAVA
    fi
fi
