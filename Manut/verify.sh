#!/bin/sh

gitlab-rake gitlab:check
gitlab-rake gitlab:doctor:secrets
