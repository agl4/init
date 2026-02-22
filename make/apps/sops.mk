# Install steps taken from https://github.com/getsops/sops/releases/tag/v3.11.0

# renovate: datasource=github-releases depName=getsops/sops versioning=semver registryUrl=https://github.com
SOPS_VERSION := v3.12.1

# variables copied from asdf-ghq
dir_tmp := $(shell mktemp -d)
platform := $(shell echo ${OS} | tr A-Z a-z)
architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
source_path := ${PREFIX}/sops

$(source_path) : app-cosign
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

.PHONY : app-sops-uninstall
app-sops-uninstall :
	rm ${source_path}

.PHONY : test-app-sops
test-app-sops :
	[[ -x ${HOME}/.local/bin/sops ]] || exit 1
	sops --version
	@echo "Testing successful."
