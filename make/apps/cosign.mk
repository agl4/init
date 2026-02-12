# Install steps taken from https://github.com/getsops/sops/releases/tag/v3.11.0

# renovate: datasource=github-releases depName=sigstore/cosign versioning=semver registryUrl=https://github.com
COSIGN_VERSION := v3.0.4

# variables copied from asdf-ghq
platform := $(shell echo ${OS} | tr A-Z a-z)
architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
download_url := https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-${platform}-${architecture}
source_path := ${PREFIX}/cosign

$(source_path) :
	mkdir -p $(shell dirname $@)
	curl -Lo $@ ${download_url}
	chmod u+x,g-rwx,o-rwx $@

.PHONY : app-cosign
app-cosign : ${source_path}

.PHONY : app-cosign-uninstall
app-cosign-uninstall :
	rm ${source_path}

.PHONY : test-app-cosign
test-app-cosign :
	cosign version
	@echo "Testing successful."
