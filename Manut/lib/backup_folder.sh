#!/bin/bash

# Check if arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_folder> <destination_location>"
    exit 1
fi

# Check if source folder exists
if [ ! -d "$1" ]; then
    echo "The source folder '$1' does not exist."
    exit 1
fi

# Check if destination location exists
if [ ! -d "$2" ]; then
    echo "The destination location '$2' does not exist."
    exit 1
fi

# Get the base name of the source folder
source_folder_name=$(basename "$1")

# Get the current date to add to the backup file name
current_date=$(date +"%Y-%m-%d")

# Define the backup file name
backup_filename="${source_folder_name}_${current_date}.tar.gz"

# Create the compressed backup
tar -czf "$2/$backup_filename" "$1"

echo "Backup created successfully at '$2/$backup_filename'."
