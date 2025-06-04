#!/bin/bash

#Receive a script path as argument
if [ -z "$1" ]; then
    echo "No script path provided."
    exit 1
fi

#Test if script exists
if [ ! -f "$1" ]; then
    echo "Script not found."
    exit 1
fi

#Test if script is executable
if [ ! -x "$1" ]; then
    echo "Script is not executable."
    exit 1
fi

#change the script path to map inside the container, replacing $SESOP_HOME by /mnt/sesop
# shellcheck disable=SC2001
script_path=$(echo "$1" | sed "s|${SESOP_HOME}|/mnt/sesop|g")

#Test if env var CNT_GITLAB setted
if [ -z "$CNT_GITLAB" ]; then
    echo "Env var from Gitlab container not setted"
    exit 1
fi

echo "Executing $script_path at GitLab container..."

#Execute the script inside a container
docker exec -t "${CNT_GITLAB}" sh "$script_path"