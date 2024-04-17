#!/bin/bash

#test env var CNT_GITLAB
echo "Home = ${GITLAB_HOME}"
if [ -z "$GITLAB_HOME" ]; then
  echo "Env var from Gitlab HOME not setted"
  exit 1
fi
if [ ! -d "$GITLAB_HOME" ]; then
    echo "Directory GITLAB_HOME not found"
    exit 1
fi

#Test sesop_home is setted and exists
if [ -z "$SESOP_HOME" ]; then
    echo "Env var SESOP_HOME not setted"
    exit 1
fi
if [ ! -d "$SESOP_HOME" ]; then
    echo "Directory SESOP_HOME not found"
    exit 1
fi

#test if env var CNT_GITLAB is set
if [ -z "$CNT_GITLAB" ]; then
  echo "Env var CNT_GITLAB not setted"
  exit 1
fi

#test if env var CNT_GITLAB is set
if [ -z "$PQP" ]; then
  echo "Env var PQP not setted"
  exit 1
fi
