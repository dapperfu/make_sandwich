#!/bin/sh
# sprintcommit.sh [COMMIT_TIME]
#  Arguments:
#     COMMIT_TIME: Time (s) to sleep between commits.
#        Default: 0
#        If the value is zero (0) sprintcommit.sh runs once and exits.
#
#  A tool for commiting code changes during 'in the zone' development sprints.
#
#  A brute force hammer written by a Mechanical/Industrial Engineer frustrated
#  at the disproportonate amount of time 'managing' git when we were supposed
#  to be working.
#

#MIT License
#
#Copyright (c) 2018 Jed Frey
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.

# Default commit frequency of 0, only commit once.
COMMIT_TIME=${1:-0}

# Until stop.
while [ 1 ];
do
# Fetch.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
git fetch --verbose --all --depth=100 --force --prune --prune-tags --recurse-submodules=yes --jobs=8
git fetch --verbose --all --depth=100 --force --tags --recurse-submodules=yes --jobs=8
echo

# Commit.
COMMIT_MSG=${COMMIT_MSG:-"`whoami`@`hostname`: `date --universal`"}
echo
echo --- Committing ${COMMIT_MSG}  ---
git commit --all --message "${COMMIT_MSG}" --verbose
echo

# Push.
echo
echo --- Pushing ---
git push --porcelain --tags --follow-tags --signed=false --set-upstream --verbose --progress --recurse-submodules=on-demand --verify --ipv4 origin-ssh
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
