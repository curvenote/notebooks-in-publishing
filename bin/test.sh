#!/usr/bin/env bash

# Set the directory to search for .xml files in
dir="./examples"
# Get the first argument or set a default value of "jats"
test=${1:-jats}

# Initialize an array to collect the exit codes
exit_codes=()

# Loop over each file in the directory
for folder in $dir/*; do
    if [ -d "$folder" ]; then
        printf "\nTesting $folder\n\n"
        # Run the jats command with the appropriate arguments
        if ! jats test "$folder/$test.xml" --cases "$folder/tests.yml"; then
            # If the jats command fails, collect the exit code in the array
            exit_codes+=($?)
        fi
    fi
done

# Check if any of the jats commands failed (i.e., if the array is not empty)
if [ ${#exit_codes[@]} -gt 0 ]; then
    echo "At least one test failed."
    exit 1
fi
