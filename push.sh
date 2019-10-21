#!/bin/bash

if [[ "$MODULE_NAME" == "" ]]
then
  echo "ERROR: Module name not set."
  exit 1
fi

SKYRIM=$(readlink ~/.skyrim)
DATA="$SKYRIM/Data"

echo "Pushing to Skyrim Data Folder"


cp $MODULE_NAME.esp "$DATA/"

if [[ -e "DATA/Meshes/$MODULE_NAME/" ]]
then
  cp -r "Meshes/$MODULE_NAME" "$DATA/Meshes/"
fi

echo "Done."
