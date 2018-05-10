### Environment Setup.

## Variables
# Makefile directory
MK_DIR = $(realpath $(dir $(firstword ${MAKEFILE_LIST})))
# Project name
PROJ ?= $(notdir ${MK_DIR})
# Hostname
HOST:=$(shell hostname).local

# OS, Architecture, & Username Detection
OSNAME :=
OSARCH :=
MK_USER:=

ifeq (${OS},Windows_NT)
	MK_USER:=${USERNAME}

	OSNAME:=WIN32
	ifeq (${PROCESSOR_ARCHITECTURE},AMD64)
		OSARCH := AMD64
	endif
	ifeq (${PROCESSOR_ARCHITECTURE},x86)
		OSARCH := IA32
	endif
else
	MK_USER:=$(shell whoami)

	UNAME_S:=$(shell uname -s)
	UNAME_P:=$(shell uname -p)

	ifeq (${UNAME_S},Linux)
		OSNAME := LINUX
	endif
	ifeq (${UNAME_S},Darwin)
		OSNAME := OSX
	endif
	ifeq (${UNAME_S},FreeBSD)
		OSNAME := FreeBSD
	endif
	
	ifeq (${UNAME_P},x86_64)
		OSARCH := AMD64
	endif
	ifneq ($(filter %86,${UNAME_P}),)
		OSARCH := IA32
	endif
	ifneq ($(filter arm%,${UNAME_P}),)
		OSARCH := ARM
	endif
	
endif

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
	@$(info $${MAKEFILE_LIST}=${MAKEFILE_LIST})
	@$(info $${MK_DIR}=${MK_DIR})
	@$(info $${PROJ}=${PROJ})
	@$(info $${OSNAME}=${OSNAME})
	@$(info $${OSARCH}=${OSARCH})
	@$(info $${MK_USER}=${MK_USER})
