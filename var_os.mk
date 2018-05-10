### OS Specific Setup

# Reset
OSNAME:=
OSARCH:=

# Windows
ifeq (${OS},Windows_NT)
	OSNAME:=WIN32
	ifeq (${PROCESSOR_ARCHITECTURE},AMD64)
		OSARCH:=AMD64
	endif
	ifeq (${PROCESSOR_ARCHITECTURE},x86)
		OSARCH:=IA32
	endif
else
	HOST:=$(shell hostname)
	# name of the operating system implementation
	UNAME_S:=$(shell uname -s)
	# machine processor architecture 
	UNAME_P:=$(shell uname -p)
	
	# Convert uname output to OSNAME
	ifeq (${UNAME_S},Linux)
		OSNAME:=LINUX
	endif
	ifeq (${UNAME_S},FreeBSD)
		OSNAME:=FREEBSD
	endif
	ifeq (${UNAME_S},Darwin)
		OSNAME:=OSX
	endif
		
	# Convert uname output to OSARCH
	ifeq (${UNAME_P},x86_64)
		OSARCH:=AMD64
	endif
	ifeq (${UNAME_P},amd64)
		OSARCH:=AMD64
	endif
	ifneq ($(filter %86,${UNAME_P}),)
		OSARCH:=IA32
	endif
	ifneq ($(filter arm%,${UNAME_P}),)
		OSARCH:=ARM
	endif
endif

.PHONY: debug.os
debug.os:
	@$(info $${OSNAME}=${OSNAME})
	@$(info $${OSARCH}=${OSARCH})
