#!/usr/bin/env bash

# Set the directory to search for directories in
dir="./examples"

# Loop over each directory in the directory
for folder in "$dir"/*; do
    if [ -d "$folder" ]; then
        echo "Cleaning $folder"
        rm -rf "$folder/_build" "$folder/files" "$folder/notebook_files" "$folder/myst.xml" "$folder/quarto.xml" "$folder/.ipynb_checkpoints"
    fi
done
