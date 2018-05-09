#!/bin/sh
# A tool for commiting code changes during 'in the zone' sprints.

COMMIT_TIME=${1:-300}

while [ 1 ];
do
# Fetch everything
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
git fetch --all --tags --prune --verbose

# A commit.
COMMIT_MSG="`whoami`@`hostname`: `date --universal`"
echo
echo --- Committing: ${COMMIT_MSG}  ---
echo 
git commit --all --message "${COMMIT_MSG}"

# Push
echo
echo --- Pushing ---
echo 
git push --all --verbose

# Sleep for 15 minutes
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
sleep ${COMMIT_TIME}
done
