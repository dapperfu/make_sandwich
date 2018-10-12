## Variables
COMMIT_TIME?=0

## Targets
# Fire - Git Fire
#
# Git actions to do in event of a fire.
# Life Hack: Run this during fire drills to make sure your setup is working.
.PHONY: fire.git
fire.git:
	@echo '####### ### ######  #######'
	@echo '#        #  #     # #'
	@echo '#        #  #     # #'
	@echo '#####    #  ######  #####'
	@echo '#        #  #   #   #'
	@echo '#        #  #    #  #'
	@echo '#       ### #     # #######'
	${MAKE} --makefile=${SANDWICH_DIR}/env.mk git.sprintcommit COMMIT_MSG="FIRE: $(shell date --universal)"
	@echo 'Please call: 0118 999 881 999 119 725'
	@sleep 5
	@echo '3'

# Env - Git Environment
#
# Setup the git environment.
# -
.PHONY: env.git
env.git:
	#
	# Add remote 'origin-ssh' based on origin. Replace the https clone urls with ssh ones.
	#
	-git remote add --fetch --tags --mirror=push origin-ssh  `git remote get-url origin | sed "s/https:\/\//git@/" | sed "s/.com\//.com:/"`
	#
	# Set push upstream to origin-ssh
	#
	-git push --set-upstream origin-ssh
	#
	# Set push default as simple
	#
	git config push.default simple
	#
	# Configure the git user email based on user, project, machine host and OS variables.
	# (To narrow down where development actually occured)
	#
	git config user.email "${USER}+${PROJ}@${HOST}-${OSNAME}"
	#
	# Configure the git user name from USER variable
	#
	git config user.name "${USER}"
	#
	# Dump the list of remotes so the user can't claim they didn't see them at least once.
	#
	git remote -v

# Commit - Git Commit
#
# 1. Fetches all remotes before creating commit to avoid issues.
# 2. Creates a commit with all changed files.
#	Pro-tip, set EDITOR to something you like.
# 3. Pushes to origin-ssh.
.PHONY: git.commit
git.commit: env.git
	git fetch --all --verbose
	git commit --all
	git push origin-ssh

# Heads - List all heads
#
# Keep track of all development with verbose printing of the heads for:
# - Local (refs/heads)
# - Tags (/refs/tags)
# - Remote (/refs/remotes/)
#
# Use cases:
# - See who is actually working.
# - Remember what branch you were working on on that one machine last weekend when you fixed that one bug.
# - Figure out what release your company is on vs where you're working.
.PHONY: git.heads
git.heads:
	@echo --- Project: "${PROJ}" ---
	@git remote --verbose
	@echo --- Head Commits ---
	@git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Tag Commits ---
	@git for-each-ref --sort=committerdate refs/tags/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Remote Commits ---
	@git for-each-ref --sort=committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

# Develop - Begin development of this project.
#
# Start development of this project at this point.
# Creates a development branch on all submodules with this project name.
# Creates a development branch for this project.
#
# See: ```git.mkdevbranch```
.PHONY: git.develop
git.develop: git.mkdevbranch
	# For each submodule also make a development branch.
	git submodule foreach make git.mkdevbranch PROJ=${PROJ} USER=${USER} BADHACK="/submodule"
	git commit --allow-empty --all --message "${USER} started ${PROJ} development"
	git commit -am "${USER} started ${PROJ} development"

# mkdevbranch - Create a development branch for this git repository.
# 1. Sets the remote push URL to the ssh version. (Tested on GitHub)
# 2. Creates a branch with the following structure:
#		development/${USER}/submodule/${PROJ}/${DATE_Y_b}
# 3. Commits all existing changes wih the following commit message:
#		${USER} started ${PROJ} development
# 4. Pushes to the origin.

BADHACK?=
.PHONY: git.mkdevbranch
git.mkdevbranch: env.git
	-git checkout --track -b development/${USER}${BADHACK}/${PROJ}/${DATE_Y_b}
	git commit --allow-empty --all --message "${USER} started ${PROJ} development"

# Sync - Sync project and all submodules with remotes
#
# Sync all submodules
.PHONY: git.sync
git.sync: env.git
	git fetch --jobs 8 --recurse-submodules --all --tags --progress
	git push --recurse-submodules=on-demand --progress --porcelain origin-ssh


## Development Sprint
.PHONY: git.sprint
git.sprint:
	${MAKE} git.sprintcommit COMMIT_TIME=300

.PHONY: git.sprintcommit
git.sprintcommit: env.git
	-echo ${PROJ}
	git submodule foreach "make git.sprintcommit PROJ=${PROJ} COMMIT_TIME=0"
