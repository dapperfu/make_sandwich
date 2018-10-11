#!/usr/bin/env bash
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
# Files to add in git.
ADD_PATHSPEC=${ADD_PATHSPEC:-0}

GIT_BIN=${GIT_BIN:-git}

DEBUG=${DEBUG:-0}


if [ "${DEBUG}" -nq "0" ]; then

echo ${0}

echo ${COMMIT_TIME}
echo ${ADD_PATHSPEC}
echo ${GIT_BIN}
exit 0

fi
# The boring stuff of git, automated.
while [ 1 ];
do
# Fetch.
echo ----------------
echo --- Fetching ---
echo ----------------
${GIT_BIN} fetch --verbose --all --depth=100 --force --recurse-submodules=no --jobs=8
${GIT_BIN} fetch --verbose --all --force --tags --recurse-submodules=no --jobs=8
echo

# Add.
if [ "${ADD_PATHSPEC}" -nq "0" ]; then
echo
echo ----------------
echo --- Adding "${ADD_PATHSPEC}" ---
echo ----------------
${GIT_BIN} add --verbose -- "${ADD_PATHSPEC}"
fi

# Commit.
COMMIT_MSG=${COMMIT_MSG:-"`hostname`: `date --universal`"}
echo
echo ----------------
echo --- Committing ${COMMIT_MSG}  ---
echo ----------------
${GIT_BIN} commit --all --message "${COMMIT_MSG}" --verbose
echo

# Push.
echo
echo ----------------
echo --- Pushing ---
echo ----------------
${GIT_BIN} push --porcelain --tags --follow-tags --signed=false --set-upstream --verbose --progress --recurse-submodules=on-demand --verify --ipv4 origin-ssh
echo

# Break if asked.
if [ "${COMMIT_TIME}" -eq "0" ]; then
   exit 0
fi


# Sleep.
echo
echo --- Sleeping until `date -d "+${COMMIT_TIME} second"` ---
echo ---------------------------------------------------------
echo `fortune`
echo ---------------------------------------------------------
sleep ${COMMIT_TIME}
done
