#!/bin/sh

git submodule foreach --recursive git checkout development/jed-frey/submodule/jupyter_NotebookCleaners/2018-Sep
git submodule foreach --recursive git commit -am '.'
git submodule foreach --recursive git push
git submodule foreach --recursive git pull
git submodule foreach --recursive make -f env.mk env.git
git submodule foreach --recursive git submodule init
git submodule foreach --recursive git submodule update
