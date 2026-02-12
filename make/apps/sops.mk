# Install steps taken from https://github.com/getsops/sops/releases/tag/v3.11.0

# renovate: datasource=github-releases depName=getsops/sops versioning=semver registryUrl=https://github.com
SOPS_VERSION := v3.11.0

# variables copied from asdf-ghq
dir_tmp := $(shell mktemp -d)
platform := $(shell echo ${OS} | tr A-Z a-z)
architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
install_path := ${PREFIX}

# https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.checksums.txt
# https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.checksums.pem
# https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.checksums.sig
# https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.darwin.arm64
# https://github.com/getsops/sops/releases/download/v3.11.0/sops-v3.11.0.linux.amd64
source_path := ${PREFIX}/sops

# Lines copied from script
$(source_path) :
	cd ${dir_tmp} && \
		curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.${platform}.${architecture} && \
		curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.txt && \
		curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.pem && \
		curl -LO https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.checksums.sig && \
		cosign verify-blob sops-${SOPS_VERSION}.checksums.txt \
			--certificate sops-${SOPS_VERSION}.checksums.pem \
			--signature sops-${SOPS_VERSION}.checksums.sig \
			--certificate-identity-regexp=https://github.com/getsops \
			--certificate-oidc-issuer=https://token.actions.githubusercontent.com && \
		sha256sum -c sops-${SOPS_VERSION}.checksums.txt --ignore-missing && \
		cp sops-${SOPS_VERSION}.${platform}.${architecture} $@ && \
		chmod u+x,g-rwx,o-rwx $@

.PHONY : app-sops
app-sops : ${source_path}

.PHONY : test-app-sops
test-app-sops :
	[[ -x ${HOME}/.local/bin/sops ]] || exit 1
	sops --version
	@echo "Testing successful."
