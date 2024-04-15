#!/bin/sh


#test env var CNT_GITLAB
echo "Home = ${GITLAB_HOME}"
if [ -z "$GITLAB_HOME" ]; then
  echo "Env var from Gitlab HOME not setted"
  exit 1
fi

#test env var CNT_GITLAB_COMPOSE
if [ -z "$GITLAB_COMPOSE" ]; then
    #Append to cnt_gitlab variable
    GITLAB_COMPOSE="${GITLAB_HOME}""/docker-compose.yml"
fi

#test docker-compose file exists
if [ ! -f "$GITLAB_COMPOSE" ]; then
    echo "Docker-compose file not found"
    exit 1
fi


echo "Rebuilding the container..."
echo "Stopping the container..."
docker stop "${CNT_GITLAB}"
echo "Removing the container..."
docker rm "${CNT_GITLAB}"

echo "Rebuilding the container..."
#push current directory
curr_dir="$PWD"
# shellcheck disable=SC2164
cd "${GITLAB_HOME}"
echo "Do you want to rebuild the container? [y/n] "
# shellcheck disable=SC3045
read -n 1 -r REPLY
#if cancelled, exit
if [ ! "$REPLY" = "Y" ] && [ ! "$REPLY" = "y" ]; then
    echo "Cancelled."
    # shellcheck disable=SC2164
    cd "${curr_dir}" 
    exit 1
fi
echo "Using docker-compose file: ${GITLAB_COMPOSE}"
docker-compose -f "${GITLAB_COMPOSE}" up -d
# shellcheck disable=SC2164
cd "${curr_dir}" 
echo "Container rebuilt."
echo "Done."

