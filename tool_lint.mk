### Code Linting & Formatting

# Config
FORMAT_EXT?=*.ino;*.cpp;*.c;*.h
CLANG_VER?=6.0

CLANG_FORMAT:=$(shell which clang-format-${CLANG_VER})

FIND_FLAGS:=-iname '$(subst ;,' -o -iname ',${FORMAT_EXT})'
.PHONY: format
format:
	find ${MK_DIR} ${FIND_FLAGS} | xargs --max-procs=8 ${CLANG_FORMAT} -i -style=file

.PHONY: lint
lint:
	$(error TODO: make lint)
