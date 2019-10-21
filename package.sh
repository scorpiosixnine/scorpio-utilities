#!/bin/bash

source ./version.sh

VERSION="$MAJOR.$MINOR.$PATCH"
NAME="Smalls-$VERSION-$BUILD_NO"
FOLDER="Releases/Smalls"
ARCHIVE="$NAME.zip"

DATA="/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Data"
cp "$DATA/Smalls.esp" .

mkdir -p "$FOLDER/Smalls/Source"

cp "$DATA/Smalls.esp" "$FOLDER/Smalls/"
cp -r Source/Scripts "$FOLDER/Smalls/Source/Scripts"
cp "$DATA/Source/Scripts/SmallsQuest.psc" "$FOLDER/Smalls/Source/Scripts/"

mkdir -p "$FOLDER/Smalls/Scripts"
for f in "$FOLDER/Smalls/Source/Scripts/"*
do
  filename=$(basename -- "$f")
  name="${filename%.*}"
  cp "$DATA/Scripts/$name.pex" "$FOLDER/Smalls/Scripts/"
done

cp -r fomod "$FOLDER/"
sed -i "s/{VERSION}/$VERSION/g" "$FOLDER/fomod/info.xml"

rm "Releases/$ARCHIVE"
cd "Releases/Smalls"
zip -r "../$ARCHIVE" "fomod" "Smalls"
cd ../..

rm -rf "$FOLDER"
