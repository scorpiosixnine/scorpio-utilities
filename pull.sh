#!/bin/bash

DATA="/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Data"

mkdir -p Source/Scripts
mkdir -p Scripts
mkdir -p Meshes/$MODULE_NAME

cp "$DATA/Source/Scripts/"*$MODULE_NAME* Source/Scripts/
cp "$DATA/$MODULE_NAME.esp" .
