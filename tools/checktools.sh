#!/bin/bash
DIR=`dirname $0`

if ( [ ! -f "${DIR}/apktool.jar" ] ||
     [ ! -f "${DIR}/zipalign" ] ||
     [ ! -f "${DIR}/update_blank.zip" ] );
then
    exit 1
fi

chmod +x ${DIR}/apktool.jar
chmod +x ${DIR}/zipalign
