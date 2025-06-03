#!/bin/sh

#*For Debian copy to /etc/profiles.d/ 
export GITLAB_IMAGE="gitlab/gitlab-ce:16.5.1-ce.0"
export GITLAB_HOME=/srv/gitlab
export SESOP_HOME=/srv/sesop
export CNT_GITLAB="gitlab-web-1"
export GITLAB_DOCKERNAME="gitlab-web-1"
export GITLAB_HOSTNAME="git-home.local"
export GITLAB_URL="https://${GITLAB_HOSTNAME}"