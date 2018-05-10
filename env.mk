### Environment Setup.

## Variables
MK_DIR:=$(realpath $(dir $(firstword ${MAKEFILE_LIST})))
SANDWICH_DIR:=$(realpath $(dir $(lastword ${MAKEFILE_LIST})))

# Project name
PROJ?=$(notdir ${MK_DIR})

## Targets
# Clean environment.
.PHONY: clean
clean:
	@echo --- Cleaning ${PROJ} ---
	# If it's not in Git, it doesn't exist.
	@git clean -xfd
	
# Debug
.PHONY: debug
debug:
	@$(info $${MK_DIR}='${MK_DIR}')
	@$(info $${SANDWICH_DIR}='${SANDWICH_DIR}')
	@$(info $${PROJ}='${PROJ}')

# Variables
include ${SANDWICH_DIR}/var_os.mk
# Environments
include ${SANDWICH_DIR}/env_host.mk
include ${SANDWICH_DIR}/env_python.mk
include ${SANDWICH_DIR}/env_arduino.mk
# Tools
include ${SANDWICH_DIR}/tool_git.mk
include ${SANDWICH_DIR}/tool_lint.mk
