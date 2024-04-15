#!/bin/bash

gitlab-rake gitlab:check
gitlab-rake gitlab:doctor:secrets
