#!/bin/bash

# Set the directory to search for .xml files in
dir="./examples"

# Loop over each folder in the directory
for folder in $dir/*; do
    if [ -d "$folder" ]; then
        echo "Building $folder"
        # Extract the filename without the extension
        filename=$(basename "$file" .ipynb)
        pushd "$folder" > /dev/null
        # Create the jats
        myst build "notebook.ipynb" -o "myst.xml"
        quarto render "notebook.ipynb" --to jats -o "quarto.xml"
        popd > /dev/null
    fi
done
