#!/bin/bash
ADB=`type -p adb`
if ! [[ "$ADB" ]]; then
    echo "ERROR: ADB is required"
    echo "Try 'sudo apt-get install android-tools-adb' on Ubuntu"
    echo "or install Android SDK Tools into your PATH"
    exit 1
fi

rm -f stock/SystemUI.apk
rm -f stock/framework-res.apk
mkdir -p stock

echo "Downloading via ADB..."
$ADB pull /system/priv-app/SystemUI/SystemUI.apk stock/ &>/dev/null
$ADB pull /system/framework/framework-res.apk stock/ &>/dev/null

if ( [ -f "stock/SystemUI.apk" ] && [ -f "stock/framework-res.apk" ] ); then
    echo "Download succesful"
else
    echo "ERROR: Failed to pull files"
    echo "Check USB connection and USB debugging settings"
    exit 1
fi
