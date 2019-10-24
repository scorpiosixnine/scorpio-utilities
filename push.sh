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

echo "Pushing to Skyrim Data Folder"


cp $MODULE_NAME.esp "$DATA/"

if [[ -e "DATA/Meshes/$MODULE_NAME/" ]]
then
  cp -r "Meshes/$MODULE_NAME" "$DATA/Meshes/"
fi

echo "Done."
