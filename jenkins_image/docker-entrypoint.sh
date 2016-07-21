#!/bin/bash
set -eo pipefail

# Add local user;
# Either use the 
# - JENKINS_USER_ID and
# - JENKINS_GROUP_ID
# if passed in at runtime or fallback.
USER_ID=${JENKINS_USER_ID:-9001}
GROUP_ID=${JENKINS_GROUP_ID:-9001}
echo "Starting with UID and GID: $USER_ID:$GROUP_ID"
usermod -u $USER_ID jenkins
groupmod -g $GROUP_ID jenkins

# update permissions
chown -R jenkins.jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# run command
exec "$@"
