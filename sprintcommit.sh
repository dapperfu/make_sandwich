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

# Commit.
COMMIT_MSG=${COMMIT_MSG:-"`whoami`@`hostname`: `date --universal`"}
echo
echo --- Committing ${COMMIT_MSG}  ---
echo

# Push.
echo
echo --- Pushing ---
echo

# For recursion.
if [ "${COMMIT_TIME}" -eq "0" ]; then
   exit 0
fi
# Sleep.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo
sleep 10 # ${COMMIT_TIME}
done
