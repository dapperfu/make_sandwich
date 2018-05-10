### Arduino Setup.

## Config
# Versions to get.
ARDUINO_VERSION ?= 1.8.5
ARDUINO_MK_VERSION ?= 1.6.0

# Download URLs
ARDUINO_MK_URL ?= https://github.com/sudar/Arduino-Makefile/archive/${ARDUINO_MK_VERSION}.tar.gz
ARDUINO_URL ?= https://github.com/arduino/Arduino/archive/${ARDUINO_VERSION}.tar.gz

# Download Command
DOWNLOAD_CMD ?= curl --silent --location --output

## Targets
# Actual Targets

# Download the Arduino release.
arduino_${ARDUINO_VERSION}.tar.gz:
	@echo Downloading $@...
	@${DOWNLOAD_CMD} $@ ${ARDUINO_URL}

# Extract into arduino folder.
arduino: arduino_${ARDUINO_VERSION}.tar.gz
	@mkdir -p $@
	@tar -xzf $< -C $@ --strip=1

# Download the Arduino Make release.
arduino_make_${ARDUINO_MK_VERSION}.tar.gz:
	@echo Downloading $@...
	@${DOWNLOAD_CMD} $@ ${ARDUINO_MK_URL}

arduino_make: arduino_make_${ARDUINO_MK_VERSION}.tar.gz
	@mkdir -p $@
	@tar -xzf $< -C $@ --strip=1
	
## Phony Targets
# Targets that don't actually exist.
.PHONY: env.arduino
env.arduino: arduino arduino_make
