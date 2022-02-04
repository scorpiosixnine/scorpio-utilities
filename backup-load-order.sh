#!/bin/bash

name=$(date +%Y-%m-%d)
folder="/mnt/c/Users/$USER/Dropbox/Games/Skyrim/Load Orders/Working $name"
mkdir -p "$folder"
appdata="/mnt/c/Users/$USER/AppData/Local/Skyrim Special Edition"
cp "$appdata"/* "$folder"
