
.PHONY: commit
commit:
	git fetch --all --verbose
	git commit --all --long
	git push --all
