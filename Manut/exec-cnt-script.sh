#!/bin/bash

#test if is root user
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

#test if container is running
if [ "$(docker inspect -f '{{.State.Running}}' $CNT_GITLAB)" == "true" ]; then
  echo "Container $CNT_GITLAB is running"
else
  echo "Container $CNT_GITLAB is not running"
  exit 1
fi

#call script to exec inside container
docker exec -it $CNT_GITLAB /bin/bash -c "cd $GITLAB_HOME && ./exec-cnt-script.sh"