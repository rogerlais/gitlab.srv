#!/bin/bash

docker exec -t "${CNT_GITLAB}" gitlab-backup create
