#!/bin/bash

if [[ "$MODULE_NAME" == "" ]]
then
  echo "ERROR: Module name not set."
  exit 1
fi

DATA="/mnt/d/Steam/steamapps/common/Skyrim Special Edition/Data"
COMPILER="$DATA/../Papyrus Compiler/PapyrusCompiler.exe"
BUILD="Temp-Build"
SOURCE="$BUILD/Source"
OUTPUT="$BUILD/Output"

source ./version.sh

mkdir -p "$DATA/$BUILD"
mkdir -p "$DATA/$SOURCE"
mkdir -p "$DATA/$OUTPUT"

echo "Copying source"
chmod -R u+rw Source

cp Source/Scripts/* "$DATA/$SOURCE/"
cp Source/Scripts/* "$DATA/Scripts/Source" # copy to old location too

cp ${MODULE_NAME}.flg "$DATA/$SOURCE"

printf "int property pMajorVersion = $MAJOR AutoReadOnly\n" >> "$DATA/$SOURCE/${MODULE_NAME}Quest.psc"
printf "int property pMinorVersion = $MINOR AutoReadOnly\n" >> "$DATA/$SOURCE/${MODULE_NAME}Quest.psc"
printf "int property pPatchVersion = $PATCH AutoReadOnly\n" >> "$DATA/$SOURCE/${MODULE_NAME}Quest.psc"
printf "int property pBuildNumber = $BUILD_NO AutoReadOnly\n" >> "$DATA/$SOURCE/${MODULE_NAME}Quest.psc"

echo "Compiling"
pushd "$DATA"
ls "$SOURCE"

"$COMPILER" "$SOURCE" -all -o="$OUTPUT" -i="Scripts/Source" -i="Source/Scripts" -f="$SOURCE/${MODULE_NAME}.flg"

echo "Copying Output"
cp "$OUTPUT/"*.pex "Scripts/"
cp "$SOURCE/"*.psc "Source/Scripts/"
popd

touch "$DATA/${MODULE_NAME}.esp"

cp "$DATA/${MODULE_NAME}.esp" .

MESHES="Meshes/${MODULE_NAME}"
mkdir -p "$MESHES"
cp -r "$DATA/$MESHES/"*.nif "$MESHES"

rm -r "$DATA/$BUILD"
