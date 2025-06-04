#!/bin/bash

#Get docker version
DOCKER_VERSION=$(docker -v)
# shellcheck disable=SC2181
if [ $? -ne 0 ]; then
    echo "Docker not found"
    exit 1
else
    echo "Docker found: $DOCKER_VERSION"
fi

#take the parent path of the script to find the root of the project
REF_PATH="$(dirname "$(dirname "$(realpath "$0")")")"

#Test if env vars file exists
if [ -f "/etc/profiles.d/docker-env.sh" ]; then
    echo -e "\033[31mError: Previous file docker-env.sh found at /etc/profiles.d/.\033[0m"
    exit 1
else
    echo "Copying file docker-env.sh to /etc/profiles.d/"
    cp "$REF_PATH"/deploy_data/profile.d/docker-env.sh /etc/profile.d/
    echo "File docker-env.sh copied to /etc/profiles.d/"
    #Call register of env vars
    # shellcheck source=/dev/null
    source /etc/profiles.d/docker-env.sh
    echo "Environment variables loaded from /etc/profile.d/docker-env.sh"
fi

#Test if /srv/gitlab exists
if [ -d "/srv/gitlab" ]; then
    echo -e "\033[31mError: Previous directory /srv/gitlab found(not empty install).\033[0m"
    exit 1
else
    echo "Creating directory /srv/gitlab"
    mkdir -p /srv/gitlab
    cp "$REF_PATH"/deploy_data/gitlab/docker-compose.yml /srv/gitlab/
fi

#Test if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    # shellcheck source=/dev/null
    source "$REF_PATH"/install/install-docker.sh
else
    echo "Docker is already installed."
fi

#Test if all env vars are set
if [ -z "$GITLAB_HOME" ] || [ -z "$CNT_GITLAB" ] || [ -z "$GITLAB_IMAGE" ] || [ -z "$GITLAB_HOSTNAME"] || [ -z "$GITLAB_URL"] || [-z "$SESOP_HOME"]; then
    echo -e "\033[31mError: Environment variables are not set.\033[0m"
    exit 1
else
    echo "Environment variables are set."
fi

# shellcheck source=/dev/null
source "$REF_PATH"/Manut/rebuild-srv-container.sh