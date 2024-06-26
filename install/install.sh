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
    echo "Previous file docker-env.sh found at /etc/profiles.d/"
    exit 1
else
    echo "Copying file docker-env.sh to /etc/profiles.d/"
    cp "$REF_PATH"/deploy_data/profile.d/docker-env.sh /etc/profile.d/
fi

#Test if /srv/gitlab exists
if [ -d "/srv/gitlab" ]; then
    echo "Previous directory /srv/gitlab found(not empty install)"
    exit 1
else
    echo "Creating directory /srv/gitlab"
    mkdir -p /srv/gitlab
    cp "$REF_PATH"/deploy_data/gitlab/docker-compose.yml /srv/gitlab/
fi

#Call register of env vars
# shellcheck source=/dev/null
source /etc/profiles.d/docker-env.sh

# shellcheck source=/dev/null
source "$REF_PATH"/Manut/rebuild-srv-container.sh

