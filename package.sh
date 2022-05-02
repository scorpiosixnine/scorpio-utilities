#!/bin/bash

source scorpio-utilities/build.sh

set -x

NAME="$MODULE_NAME-$VERSION-$BUILD_NO"
PACKAGE="Releases/$MODULE_NAME"
MOD="$PACKAGE/$MODULE_NAME"
ARCHIVE="$NAME.zip"

mkdir -p "$MOD/Scripts"
mkdir -p "$MOD/Source/Scripts"

# Copy the esp 
cp "$MODULE_NAME.esp" "$MOD"

# Copy expanded source
cp "$SOURCE/"*.psc "$MOD/Source/Scripts/"

# Copy other content
cp -r "$CONTENT"/* "$MOD/"

# Copy compiled scripts
cp "$OUTPUT/"*.pex "$MOD/Scripts/"

# Copy fomod
cp -r fomod "$PACKAGE/"
sed -i "s/{VERSION}/$VERSION/g" "$PACKAGE/fomod/info.xml"

rm "Releases/$ARCHIVE"
cd "Releases/$MODULE_NAME"
zip -r "../$ARCHIVE" "fomod" "$MODULE_NAME"
cd ../..

rm -rf "$PACKAGE"
