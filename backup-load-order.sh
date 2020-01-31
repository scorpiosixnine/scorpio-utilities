#!/bin/bash

name=$(date +%Y-%m-%d)
folder="/mnt/c/Users/sam/Dropbox/Games/Skyrim/Load Orders/Working $name"
mkdir -p "$folder"
appdata="/mnt/c/Users/sam/AppData/Local/Skyrim Special Edition"
cp "$appdata"/* "$folder"
