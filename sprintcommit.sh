#!/bin/sh
# A tool for commiting code changes during 'in the zone' sprints.

COMMIT_TIME=${1:-300}

while [ 1 ];
do
# Fetch everything
git fetch --all --tags --prune --verbose

# A commit.
git commit --all --message "`whoami`@`hostname`: `date --universal`"

# Push
git push --all --tags --verbose

# Sleep for 15 minutes
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
sleep ${COMMIT_TIME}
done
