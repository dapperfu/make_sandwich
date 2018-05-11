## Commit
.PHONY: commit
commit:
	git fetch --all --verbose
	git commit --all --long
	git push --all

##
.PHONY: git.heads
git.heads:
	@echo --- Head Commits ---
	@git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Tag Commits ---
	@git for-each-ref --sort=committerdate refs/tags/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	@echo --- Remote Commits ---
	@git for-each-ref --sort=committerdate refs/remotes/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'

## Development Sprint
.PHONY: sprint
sprint:
	$(shell $(realpath ${MK_DIR}/.mk_inc/sprintcommit.sh))
## Reset
.PHONY: reset
reset:
	-git reset HEAD --hard
	${MAKE} clean
