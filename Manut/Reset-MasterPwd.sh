#!/bin/bash

#Test if env var gitlab_service setted
if [ -z "$gitlab_service" ]; then
  echo "Env var gitlab_service not setted"
  exit 1
fi


docker exec -it <ID do Container> /bin/bash
