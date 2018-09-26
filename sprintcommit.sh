#!/bin/sh
# A tool for commiting code changes during 'in the zone' sprints.

# Default commit frequency of 0, only commit once.
COMMIT_TIME=${1:-0}

# Until stop.
while [ 1 ];
do
# Fetch.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
git fetch --all --tags --prune --verbose

# Commit.
COMMIT_MSG=${COMMIT_MSG:-"`whoami`@`hostname`: `date --universal`"}
echo
echo --- Committing ${COMMIT_MSG}  ---
echo
git commit --all --message "${COMMIT_MSG}"

# Push.
echo
echo --- Pushing ---
echo 
git push --all --verbose

# For recursion.
if [ "${COMMIT_TIME}" -eq "0" ]; then
   exit 0
fi
# Sleep.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo 
sleep ${COMMIT_TIME}
done
