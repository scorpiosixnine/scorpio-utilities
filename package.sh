#!/bin/bash


if [[ "$MODULE_NAME" == "" ]]
then
  echo "ERROR: Module name not set."
  exit 1
fi

if [[ "$SKYRIM_HOME" == "" ]]
then
  echo "ERROR: Skyrim location name not set."
  exit 1
fi

DATA="$SKYRIM_HOME/Data"


NAME="$MODULE_NAME-$VERSION-$BUILD_NO"
FOLDER="Releases/$MODULE_NAME"
ARCHIVE="$NAME.zip"

cp "$DATA/$MODULE_NAME.esp" .

mkdir -p "$FOLDER/$MODULE_NAME/Source"

cp "$DATA/$MODULE_NAME.esp" "$FOLDER/$MODULE_NAME/"
cp -r Source/Scripts "$FOLDER/$MODULE_NAME/Source/Scripts"

# grab substituted source directly from the data folder
cp "$DATA/Source/Scripts/$MODULE_NAMEQuest.psc" "$FOLDER/$MODULE_NAME/Source/Scripts/"
cp "$DATA/Source/Scripts/$MODULE_NAMEConfig.psc" "$FOLDER/$MODULE_NAME/Source/Scripts/"

mkdir -p "$FOLDER/$MODULE_NAME/Scripts"
for f in "$FOLDER/$MODULE_NAME/Source/Scripts/"*
do
  filename=$(basename -- "$f")
  name="${filename%.*}"
  cp "$DATA/Scripts/$name.pex" "$FOLDER/$MODULE_NAME/Scripts/"
done

cp -r fomod "$FOLDER/"
sed -i "s/{VERSION}/$VERSION/g" "$FOLDER/fomod/info.xml"

rm "Releases/$ARCHIVE"
cd "Releases/$MODULE_NAME"
zip -r "../$ARCHIVE" "fomod" "$MODULE_NAME"
cd ../..

rm -rf "$FOLDER"
