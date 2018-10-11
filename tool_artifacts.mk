# Download artifacts.
ARTIFACT_PTR=$(wildcard artifacts/*.txt)
ARTIFACT_FILES=$(patsubst %.txt,%,${ARTIFACT_PTR})
.PHONY: artifacts
artifacts: ${ARTIFACT_FILES}
