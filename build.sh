#!/bin/bash

if [[ "$MODULE_NAME" == "" ]]
then
  echo "ERROR: Module name not set."
  exit 1
fi

if [[ "$SKYRIM_HOME" == "" ]]
then
  echo "ERROR: Skyrim location name not set."
  echo "Set SKYRIM_HOME and run again."
  exit 1
fi

DATA="$SKYRIM_HOME/Data"

COMPILER="$DATA/../Papyrus Compiler/PapyrusCompiler.exe"
VORTEX="/mnt/c/Users/Sam Deane/AppData/Roaming/Vortex"
BUILD="Temp-Build"
SOURCE="$BUILD/Source"
DEPENDENCIES="$BUILD/Dependencies"
OUTPUT="$BUILD/Output"

mkdir -p "$SOURCE"
mkdir -p "$DEPENDENCIES"
mkdir -p "$OUTPUT"

# Copy source into temporary build location
echo "Copying source"
cp Source/Scripts/* "$SOURCE/"
cp ${MODULE_NAME}.flg "$SOURCE"

# Copy Version info and utilities into the main Quest script
echo "Updating Quest Script"
QUEST="$SOURCE/${MODULE_NAME}Quest.psc"
printf "\n\n; Version info (automatically exported).\n" >> "$QUEST"
printf "String property pName = \"$MODULE_NAME\" AutoReadOnly\n" >> "$QUEST"
printf "int property pMajorVersion = $MAJOR AutoReadOnly\n" >> "$QUEST"
printf "int property pMinorVersion = $MINOR AutoReadOnly\n" >> "$QUEST"
printf "int property pPatchVersion = $PATCH AutoReadOnly\n" >> "$QUEST"
printf "int property pBuildNumber = $BUILD_NO AutoReadOnly\n" >> "$QUEST"
cat "scorpio-utilities/QuestUtilities.psc" >> "$QUEST"

# Copy utilities into the main Config script
echo "Updating Config Script"
CONFIG="$SOURCE/${MODULE_NAME}Config.psc"
cat "scorpio-utilities/ConfigUtilities.psc" >> "$CONFIG"

# Compile
echo "Compiling $SOURCE to $OUTPUT"

"$COMPILER" "$SOURCE" -a -o="$OUTPUT" -i="$SOURCE;$SDKS" -f="$SOURCE/${MODULE_NAME}.flg" 2> "$OUTPUT/compile.log"
COMPILE_RESULT=$?

# Copy expanded source into Skyrim's source folder
cp "$SOURCE/"*.psc "$DATA/Source/Scripts/"

# Copy compiled output into Skyrim Scripts folders
echo "Copying Output"
cp "$OUTPUT/"*.pex "Scripts/"
popd > /dev/null

# Touch the main module file, to update the modification date
touch "$DATA/${MODULE_NAME}.esp"

# Copy back the module file and meshes into our directory to make sure we've got the latest source
cp "$DATA/${MODULE_NAME}.esp" .
MESHES="Meshes/${MODULE_NAME}"
if [[ -e "$DATA/$MESHES"*.nif ]]
then
  mkdir -p "$MESHES"
  cp -r "$DATA/$MESHES/"*.nif "$MESHES"
fi

printf "\nDone building $MODULE_NAME $MAJOR.$MINOR.$PATCH ($BUILD_NO).\n\n"

if [[ $COMPILE_RESULT == 0 ]]
then
  printf "BUILD SUCCEEDED.\n\n"
else
  printf "BUILD FAILED.\n\n"
  cat "$DATA/$OUTPUT/compile.log"
fi

# Remove the temporary build folder
rm -r "$BUILD"
