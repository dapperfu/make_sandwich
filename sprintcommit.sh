#!/bin/sh
# A tool for commiting code changes during 'in the zone' sprints.

# Default commit frequency every 300 seconds unless otherwise given.
COMMIT_TIME=${1:-300}

# Until stop.
while [ 1 ];
do
# Fetch.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
git fetch --all --tags --prune --verbose

# Commit.
COMMIT_MSG="`whoami`@`hostname`: `date --universal`"
echo
echo --- Committing ${COMMIT_MSG}  ---
echo
git commit --all --message "${COMMIT_MSG}"

# Push.
echo
echo --- Pushing ---
echo 
git push --all --verbose

# Sleep.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
sleep ${COMMIT_TIME}
done
