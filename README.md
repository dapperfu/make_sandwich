# make_sandwich

![](https://imgs.xkcd.com/comics/sandwich.png )

Tool chest for [GNU Make](https://www.gnu.org/software/make/) targets.

# Usage

Add project as submodule to project and copy template Makefile to the project directory:

    git submodule add https://github.com/jed-frey/make_sandwich.git .mk_inc
    cp .mk_inc/Makefile ./

By default, intentionally, there is no target. Running make after the above commands should result in a message that there is no default target.

    $ make
    Makefile:7: *** No Default Target.  Stop.

## Targets

    make clean

Clean the project. To reduce problems and increase repeatability ```clean``` executes ```git clean -xfd```. 

    make debug
    make debug.dates
    make debug.host
    make debug.os

Print variables set in the respective areas. Used as a sniff test.

    make env.arduino
    make env.git
    make env.host
    make env.python

Setup the given environment for the project. ```make env.host``` requires admin access.


## Motivation

For projects that used Python I had a lot of a boilerplate in my ```Makefile``` that evolved over time. ```make_sandwich``` is a consolidation of a lot of common targets that I used.

Since starting to use it I've noticed the time getting started on a new project has been significantly reduced.