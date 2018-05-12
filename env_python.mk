### Python Make Targets

## Configuration
# Virtual environment path
VENV ?= ${MK_DIR}

# Base python modules to install before everything else
# Some projects need wheel to setup, others numpy, etc.
BASE_MODULES+=pip setuptools wheel

## Variable Setup
# Executable paths
PY_BIN:=${VENV}/bin
PIP:=${PY_BIN}/pip
PYTHON:=${PY_BIN}/python

## Targets
.PHONY: env.python
env.python: ${PYTHON}

${PYTHON}: requirements.txt
	python3 -mvenv ${VENV}
	${PIP} install --upgrade ${BASE_MODULES}
	${PIP} install --upgrade --requirement ${<}
	
.PHONY: test.python
test.python:
	${PY_BIN}/pytest tests/
	
requirements.txt:
	$(file >${@},)
