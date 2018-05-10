# Config

## Targets
# Do nothing.
.PHONY: null
null:
	@$(error No Default Target).

## make_sandwich includes
# https://github.com/jed-frey/make_sandwich
# 
include .mk_inc/env.mk
include .mk_inc/env_host.mk
include .mk_inc/env_python.mk
include .mk_inc/env_arduino.mk
