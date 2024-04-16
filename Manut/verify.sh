#!/bin/sh


echo "Running and checking the GitLab container..."
# Run and check the GitLab container
if gitlab-rake gitlab:check; then
    echo "GitLab container is running and healthy."
else
    echo "GitLab container check failed."
fi

if gitlab-rake gitlab:doctor:secrets; then
    echo "GitLab secrets are OK."
else
    echo "GitLab secrets check failed."
fi

if gitlab-rake gitlab:git:fsck; then
    echo "GitLab file system are OK."
else
    echo "GitLab file system check failed."
fi

