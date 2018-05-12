### Host Environment Setup.
# Bootstrap Host Environment.

# Targets

# env.host - Setup the host environment.
#
# Requires admin permissions. 
# Sets up the host machine with required packages
.PHONY: env.host
env.host: .env-${HOST}
	@echo --- Host Environment Setup For ${PROJ} on ${HOST} ---

.env-${HOST}: ${OSNAME}
	$(file >${@},)

.PHONY: LINUX 
LINUX: ${LSB_ID}
	
.PHONY: Ubuntu
Ubuntu: requirements-${LSB_ID}.txt
	grep ${LSB_RELEASE} requirements-${LSB_ID}.txt | cut -f1 -d# | xargs apt-get install -y

requirements-${LSB_ID}.txt:
	$(file >${@},)
	
.PHONY: debug.host
debug.host:
	@$(info $${LSB_RELEASE}=${LSB_RELEASE})
	@$(info $${LSB_ID}=${LSB_ID})
