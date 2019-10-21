#!/bin/bash

if [[ "$MODULE_NAME" == "" ]]
then
  echo "ERROR: Module name not set."
  exit 1
fi

DATA="/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Data"

echo "Pulling from Skyrim Data Folder"

mkdir -p Source/Scripts
mkdir -p Scripts
mkdir -p Meshes/$MODULE_NAME

cp "$DATA/$MODULE_NAME.esp" .
cp "$DATA/Source/Scripts/"*$MODULE_NAME* Source/Scripts/

if [[ -e "DATA/Meshes/$MODULE_NAME/" ]]
then
  cp -r "$DATA/Meshes/$MODULE_NAME" Meshes/
fi

echo "Done."
