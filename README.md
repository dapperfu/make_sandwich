# make_sandwich

![](https://imgs.xkcd.com/comics/sandwich.png )

Tool chest for [GNU Make](https://www.gnu.org/software/make/) targets.

# Usage

Add project as submodule to project and copy template Makefile to the project directory:

    git submodule add https://github.com/jed-frey/make_sandwich.git .mk_inc
    cp .mk_inc/Makefile ./
    
    
# Development From Submodule

Set the push URL to the SSH address. Replace with your fork.

    git remote set-url --push origin `git remote get-url origin | sed "s/https:\/\//git@/" | sed "s/.com\//.com:/"`

Create a branch for development

    git checkout -b development/submodule/[...]
    git push --set-upstream origin development/submodule/[...]

    