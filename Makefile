# Config

## Targets
# Do nothing.
.PHONY: null
null:
	@$(error No Default Target).

ifeq ("${MK_DIR}", "${SANDWICH_DIR}")
	@echo Equal
	# ${MK_DIR}
	# ${SANDWICH_DIR}
endif

ifneq ("${MK_DIR}", "${SANDWICH_DIR}")
	@echo Unequal
	# ${MK_DIR}
	# ${SANDWICH_DIR}
endif

## make_sandwich includes
# https://github.com/jed-frey/make_sandwich
include .mk_inc/env.mk
