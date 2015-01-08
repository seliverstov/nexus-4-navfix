#!/bin/bash

# Nexus 4 navigation buttons fix
#
# Author: Grigoriy Kraynov (github@gkraynov.com)
# (c) 2015
# License: MIT

if ! tools/checktools.sh; then
    echo "ERROR: Tools are not installed, use 'gettools.sh' to download them"
    exit 1
fi

JAVA=`tools/findjava.sh 7`
if ! [[ "$JAVA" ]]; then
    echo "ERROR: Java 7 or newer is required"
    exit 1
fi
APKTOOL="${JAVA} -jar tools/apktool.jar"

if ( [ ! -f "stock/framework-res.apk" ] || [ ! -f "stock/SystemUI.apk" ]); then
    echo "ERROR: Stock binaries not found, use 'pull.sh' to fetch from phone"
    exit 1
fi

WORKDIR=`pwd`
TEMPDIR="${WORKDIR}/tmp"
rm -rf $TEMPDIR
rm -f UPDATE.zip
rm -f ROLLBACK.zip
mkdir $TEMPDIR
mkdir $TEMPDIR/update

echo "Unpacking..."
$APKTOOL if stock/framework-res.apk -p $TEMPDIR/framework &>/dev/null
$APKTOOL d stock/SystemUI.apk --no-src -o $TEMPDIR/SystemUI -p $TEMPDIR/framework &>/dev/null
unzip tools/update_blank.zip -d $TEMPDIR/update &>/dev/null

echo "Patching..."
mv $TEMPDIR/SystemUI/res/values/dimens.xml $TEMPDIR/dimens.xml
cat $TEMPDIR/dimens.xml | \
sed 's/\(deadzone_size">\)\([^<]*\)\(<[^>]*\)/\10\.0dip\3/g' | \
sed 's/\(deadzone_size_max">\)\([^<]*\)\(<[^>]*\)/\10\.0dip\3/g' > $TEMPDIR/SystemUI/res/values/dimens.xml
rm $TEMPDIR/dimens.xml

echo "Building..."
mkdir $TEMPDIR/repack
$APKTOOL b $TEMPDIR/SystemUI -o $TEMPDIR/repack/SystemUI.apk -p $TEMPDIR/framework &>/dev/null
mkdir $TEMPDIR/repack/patched
unzip $TEMPDIR/repack/SystemUI.apk -d $TEMPDIR/repack/patched &>/dev/null
unzip stock/SystemUI.apk -d $TEMPDIR/repack &>/dev/null
mv $TEMPDIR/repack/patched/resources.arsc $TEMPDIR/repack/resources.arsc
rm -rf $TEMPDIR/repack/patched
rm -f $TEMPDIR/repack/SystemUI.apk

echo "Packing 'SystemUI.apk'..."
cd $TEMPDIR/repack
zip -0 SystemUI.zip -r * &>/dev/null
$WORKDIR/tools/zipalign 4 SystemUI.zip ../update/SystemUI.apk
rm SystemUI.zip
cd $WORKDIR

echo "Packing 'UPDATE.zip'..."
cd $TEMPDIR/update
zip $WORKDIR/UPDATE.zip -r * &>/dev/null
cd $WORKDIR

echo "Packing the rollback..."
rm $TEMPDIR/update/SystemUI.apk
cp stock/SystemUI.apk $TEMPDIR/update/
cd $TEMPDIR/update
zip $WORKDIR/UPDATE_ROLLBACK.zip -r * &>/dev/null
cd $WORKDIR

echo "Cleaning up..."
rm -rf $TEMPDIR

echo "Done!"
