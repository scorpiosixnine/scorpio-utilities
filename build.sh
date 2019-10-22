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

COMPILER="$DATA/../Papyrus Compiler/PapyrusCompiler.exe"
BUILD="Temp-Build"
SOURCE="$BUILD/Source"
OUTPUT="$BUILD/Output"

mkdir -p "$DATA/$BUILD"
mkdir -p "$DATA/$SOURCE"
mkdir -p "$DATA/$OUTPUT"


# Copy source into temporary build location
echo "Copying source"
cp Source/Scripts/* "$DATA/$SOURCE/"
cp ${MODULE_NAME}.flg "$DATA/$SOURCE"

# Copy Version info and utilities into the main Quest script
echo "Updating Quest Script"
QUEST="$DATA/$SOURCE/${MODULE_NAME}Quest.psc"
printf "\n\n; Version info (automatically exported).\n" >> "$QUEST"
printf "String property pName = \"$MODULE_NAME\" AutoReadOnly\n" >> "$QUEST"
printf "int property pMajorVersion = $MAJOR AutoReadOnly\n" >> "$QUEST"
printf "int property pMinorVersion = $MINOR AutoReadOnly\n" >> "$QUEST"
printf "int property pPatchVersion = $PATCH AutoReadOnly\n" >> "$QUEST"
printf "int property pBuildNumber = $BUILD_NO AutoReadOnly\n" >> "$QUEST"
cat "scorpio-utilities/QuestUtilities.psc" >> "$QUEST"

# Copy expanded source into Skyrim's source folder
pushd "$DATA"
cp "$SOURCE/"*.psc "Source/Scripts/"

# Compile
echo "Compiling"
"$COMPILER" "$SOURCE" -all -o="$OUTPUT" -i="$SOURCE" -i="Scripts/Source" -i="Source/Scripts" -f="$SOURCE/${MODULE_NAME}.flg"

# Copy compiled output, and expanded source, into Skyrim script/source folders
echo "Copying Output"
cp "$OUTPUT/"*.pex "Scripts/"
popd > /dev/null

# Touch the main module file, to update the modification date
touch "$DATA/${MODULE_NAME}.esp"

# Copy back the module file and meshes into our directory to make sure we've got the latest source
cp "$DATA/${MODULE_NAME}.esp" .
MESHES="Meshes/${MODULE_NAME}"
if [[ -e "$DATA/$MESHES" ]]
then
  mkdir -p "$MESHES"
  cp -r "$DATA/$MESHES/"*.nif "$MESHES"
fi

# Remove the temporary build folder
rm -r "$DATA/$BUILD"
