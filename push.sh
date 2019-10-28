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


function pushFolder {
  if ls "$1/$2"*/ 1> /dev/null 2>&1
  then
    ls "$1/$2"*/
    cp -r -t "$DATA/$1/" "$1/$2"*/
  fi
}

function pushKind {
  if ls "$1/$2"*.$3 1> /dev/null 2>&1
  then
    cp -t "$DATA/$1/" "$1/$2"*.$3
  fi
}

echo "Pushing to Skyrim Data Folder"

pushKind "." "$MODULE_NAME" "esp"

pushKind "CalienteTools/BodySlide/SliderSets" "$MODULE_NAME" "osp"
pushFolder "CalienteTools/BodySlide/ShapeData" "$MODULE_NAME"

pushFolder "Meshes" "$MODULE_NAME"
# if the module name is X+Y, copy meshes from `Meshes/X/Y` as well as `Meshes/X+Y`.
expanded=${MODULE_NAME/+/\/}
pushFolder "Meshes" "$MODULE_NAME"


echo "Done."
