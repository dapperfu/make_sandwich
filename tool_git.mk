## Variables

## Commit
.PHONY: commit
commit:
	git fetch --all --verbose
	git commit --all --long
	git push --all

##
.PHONY: git.origin
git.origin:
	git remote set-url --push origin `git remote get-url origin | sed "s/https:\/\//git@/" | sed "s/.com\//.com:/"`
	git remote --verbose

##
.PHONY: git.heads
git.heads:
	@echo --- Head Commits ---
	@git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Tag Commits ---
	@git for-each-ref --sort=committerdate refs/tags/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Remote Commits ---
	@git for-each-ref --sort=committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

.PHONY: git.develop
git.develop:
	git submodule foreach --recursive make git.mkdevbranch PROJ=${PROJ} USER=${USER}
	
.PHONY: git.mkdevbranch
git.mkdevbranch:
	-git checkout --track -b development/${USER}/submodule/${PROJ}/${DATE_Y_b}
	${MAKE} git.origin
	git commit -am "${USER} started ${PROJ} development"
	git push origin
	
## Development Sprint
.PHONY: sprint
sprint:
	$(shell $(realpath ${MK_DIR}/.mk_inc/sprintcommit.sh))
