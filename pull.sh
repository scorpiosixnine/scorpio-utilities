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


function copyPattern {
  if [[ -e "$DATA/$1/"*$2* ]]
  then
    mkdir -p "$1"
    cp "$DATA/$1/"*$2* "$1/"
  fi
}

function copyFolder {
  if ls "$DATA/$1/$2"*/ 1> /dev/null 2>&1
  then
    mkdir -p "$1"
    cp -r "$DATA/$1/$2"*/* "$1/"
  fi
}

function copyKind {
  if ls "$DATA/$1/$2"*.$3 1> /dev/null 2>&1
  then
    mkdir -p "$1"
    cp "$DATA/$1/$2"*.$3 "$1/"
  fi
}

echo "Pulling from Skyrim Data Folder"

mkdir -p Scripts

copyKind "." "$MODULE_NAME" "esp"

copyKind "Source/Scripts" "$MODULE_NAME" "psc"
copyKind "CalienteTools/Bodyslide/SliderSets" "$MODULE_NAME" "osp"
copyKind "CalienteTools/Bodyslide/SliderGroups" "$MODULE_NAME" "xml"
copyFolder "CalienteTools/BodySlide/ShapeData" "$MODULE_NAME"

copyFolder "Meshes" "$MODULE_NAME"
# if the module name is X+Y, copy meshes from `Meshes/X/Y` as well as `Meshes/X+Y`.
expanded=${MODULE_NAME/+/\/}
copyFolder "Meshes" "$MODULE_NAME"

echo "Done."
