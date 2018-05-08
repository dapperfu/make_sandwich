### Python Make Targets

## Config
# Virtual environment path
VENV ?= ${MK_DIR}

## Variable setup.
# Executable paths
PY_BIN:=$(realpath ${VENV}/bin)

PIP:=${PY_BIN}/pip
PYTHON:=${PY_BIN}/python

# Base python modules to install before everything else
# Some projects need wheel to setup.
BASE_MODULES+=pip setuptools wheel

.PHONY: venv
venv: ${PYTHON}

${PYTHON}: requirements.txt
	python3 -mvenv ${VENV}
	${PIP} install --upgrade ${BASE_MODULES}
	${PIP} install --upgrade --requirement ${<}
	
requirements.txt:
	$(error ${@} doesn't exist.)
