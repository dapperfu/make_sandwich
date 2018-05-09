## Commit
.PHONY: commit
commit:
	git fetch --all --verbose
	git commit --all --long
	git push --all
	
## Development Sprint
.PHONY: sprint
sprint:
	$(shell $(realpath ${MK_DIR}/.mk_inc/sprintcommit.sh))

## Reset
.PHONY: reset
reset:
	-git reset HEAD --hard
	${MAKE} clean
