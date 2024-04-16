#!/bin/bash

# Check if arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <folder_path> <file_pattern>"
    exit 1
fi

# Check if folder exists
if [ ! -d "$1" ]; then
    echo "The folder '$1' does not exist."
    exit 1
fi

# Get the total size of files matching the pattern
total_size=0
while IFS= read -r -d '' file; do
    size=$(stat -c "%s" "$file")
    ((total_size += size))
done < <(find "$1" -type f -name "$2" -print0 2>/dev/null)

# Print the total size
echo "$total_size"
