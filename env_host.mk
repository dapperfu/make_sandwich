### Host Environment Setup.
# Bootstrap Host Environment.

# Config
LSB_RELEASE:=$(shell lsb_release --short --release)
LSB_ID:=$(shell lsb_release --short --id)

# Targets
.PHONY: ubuntu
ubuntu: ${LSB_RELEASE}
	@echo --- ${PROJ} ---

.PHONY: ${LSB_RELEASE}
${LSB_RELEASE}:
	grep ${LSB_RELEASE} requirements-${LSB_ID}.txt | cut -f1 -d# | xargs apt-get install -y

.PHONY: debug.host
debug.host:
	@$(info $${LSB_RELEASE}=${LSB_RELEASE})
	@$(info $${LSB_ID}=${LSB_ID})
