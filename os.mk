### OS Specific Setup

OSNAME :=
OSARCH :=

ifeq (${OS},Windows_NT)
	OSNAME:=WIN32
	ifeq (${PROCESSOR_ARCHITECTURE},AMD64)
		OSARCH := AMD64
	endif
	ifeq (${PROCESSOR_ARCHITECTURE},x86)
		OSARCH := IA32
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq (${UNAME_S},Linux)
		OSNAME := LINUX
	endif
	ifeq (${UNAME_S},Darwin)
		OSNAME := OSX
	endif
		
	UNAME_P := $(shell uname -p)
	ifeq (${UNAME_P},x86_64)
		OSNAME := AMD64
	endif
	
	ifneq ($(filter %86,${UNAME_P}),)
		OSARCH := IA32
	endif
	ifneq ($(filter arm%,${UNAME_P}),)
		OSARCH := ARM
	endif
endif

.PHONY: debug_os
debug_os:
	@echo $(OSFLAG)
