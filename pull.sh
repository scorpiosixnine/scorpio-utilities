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

echo "Pulling from Skyrim Data Folder"

mkdir -p Source/Scripts
mkdir -p Scripts
mkdir -p Meshes/$MODULE_NAME
mkdir -p CalienteTools/Bodyslide/SliderSets/
mkdir -p CalienteTools/Bodyslide/SliderGroups/
mkdir -p CalienteTools/Bodyslide/ShapeData/$MODULE_NAME/

cp "$DATA/$MODULE_NAME.esp" .

if [[ -e "$DATA/Source/Scripts/"*$MODULE_NAME* ]]
then
  cp "$DATA/Source/Scripts/"*$MODULE_NAME* Source/Scripts/
fi

if [[ -e "$DATA/Meshes/$MODULE_NAME/" ]]
then
  cp -r "$DATA/Meshes/$MODULE_NAME" Meshes/
fi

if [[ -e "$DATA/CalienteTools/Bodyslide/SliderSets/$MODULE_NAME.osp" ]]
then
  cp -r "$DATA/CalienteTools/Bodyslide/SliderSets/$MODULE_NAME.osp" "CalienteTools/Bodyslide/SliderSets/"
fi

if [[ -e "$DATA/CalienteTools/Bodyslide/SliderGroups/$MODULE_NAME.xml" ]]
then
  cp -r "$DATA/CalienteTools/Bodyslide/SliderGroups/$MODULE_NAME.xml" "CalienteTools/Bodyslide/SliderGroups/"
fi

if [[ -e "$DATA/CalienteTools/Bodyslide/ShapeData/$MODULE_NAME/" ]]
then
  cp -r "$DATA/CalienteTools/Bodyslide/ShapeData/$MODULE_NAME/"* "CalienteTools/Bodyslide/ShapeData/$MODULE_NAME/"
fi


echo "Done."
