## Variables
COMMIT_TIME?=0

## Targets
# Fire - Fire
.PHONY: git.fire
git.fire:
	@echo '####### ### ######  #######'
	@echo '#        #  #     # #'
	@echo '#        #  #     # #'
	@echo '#####    #  ######  #####'
	@echo '#        #  #   #   #'
	@echo '#        #  #    #  #'
	@echo '#       ### #     # #######'
	${MAKE} git.sprintcommit COMMIT_MSG="FIRE"
	@echo 'Please call: 0118 999 881 999 119 725'
	@sleep 5
	@echo '3'


# Commit - Git Commit
#
# Fetches all remotes before creating commit to avoid issues.
# Creates a commit. Launches EDITOR.
# Pushes to all remotes.
.PHONY: git.commit
git.commit:
	git fetch --all --verbose
	git commit --all
	git push upstream

# Heads - List all heads
#
# Keep track of all development with verbose printing of the heads for:
# - Local (refs/heads)
# - Tags (/refs/tags)
# - Remote (/refs/remotes/)
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
# Creates a development branch on all submodules.
# Creates a development branch for this project.
#
# See: ```git.mkdevbranch```
.PHONY: git.develop
git.develop:
	-echo "Hello World"
	#git submodule foreach make git.mkdevbranch PROJ=${PROJ} USER=${USER}
	#-git checkout -b development/${USER}/${DATE_Y_b}
	#git remote set-url --push origin `git remote get-url origin | sed "s/https:\/\//git@/" | sed "s/.com\//.com:/"`
	#git commit -am "${USER} started ${PROJ} development"
	#git push --set-upstream origin

# mkdevbranch - Create a development branch for this git repository.
# 1. Sets the remote push URL to the ssh version. (Tested on GitHub)
# 2. Creates a branch with the following structure:
#		development/${USER}/submodule/${PROJ}/${DATE_Y_b}
# 3. Commits all existing changes wih the following commit message:
#		${USER} started ${PROJ} development
# 4. Pushes to the origin.

.PHONY: git.mkdevbranch
git.mkdevbranch: env.git
	-git checkout --track -b development/${USER}/submodule/${PROJ}/${DATE_Y_b}
	git commit --allow-empty --all --message "${USER} started ${PROJ} development"
	git push --set-upstream upstream

# Sync - Sync project and all submodules with remotes
#
# Sync all submodules
.PHONY: git.sync
git.sync: env.git
	git fetch --jobs 8 --recurse-submodules --all --tags --progress
	git push --recurse-submodules=on-demand --progress --porcelain upstream

.PHONY: env.git
env.git:
	-git remote add --fetch --tags --mirror=push upstream `git remote get-url origin | sed "s/https:\/\//git@/" | sed "s/.com\//.com:/"`
	git config push.default simple
	git config user.email "${USER}+${PROJ}@${HOST}-${OSNAME}"
	git config user.name "${USER}"
	git remote -v

## Development Sprint
.PHONY: git.sprint
git.sprint:
	${MAKE} git.sprintcommit COMMIT_TIME=300

.PHONY: git.sprintcommit
git.sprintcommit: env.git
	git submodule foreach "make git.sprintcommit PROJ=${PROJ}"
	-${SANDWICH_DIR}/sprintcommit.sh ${COMMIT_TIME}
