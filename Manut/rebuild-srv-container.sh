#!/bin/sh


#test env var CNT_GITLAB
if [ -z "$GITLAB_HOME" ]; then
  echo "Env var from Gitlab HOME not setted"
  exit 1
fi

#test env var CNT_GITLAB_COMPOSE
if [ -z "$GITLAB_COMPOSE" ]; then
    #Append to cnt_gitlab variable
    GITLAB_COMPOSE="${GITLAB_HOME}/docker-compose.yml"
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
cd "${GITLAB_HOME}" || { echo "Failure jump to ${GITLAB_HOME}"; exit 1; }
docker-compose -f "${CNT_GITLAB_COMPOSE}" up -d
cd "$curr_dir" || { echo "Failure jump to ${GITLAB_HOME}"; exit 1; }
echo "Container rebuilt."
echo "Done."

