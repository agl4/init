# Install steps taken from https://github.com/kajisha/asdf-ghq/blob/master/bin/install

# renovate: datasource=github-releases depName=x-motemen/ghq versioning=semver registryUrl=https://github.com
GHQ_VERSION := 1.10.1

# variables copied from asdf-ghq
ghq_platform := $(shell echo ${OS} | tr A-Z a-z)
ghq_architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
ghq_install_path := ${PREFIX}
ghq_download_url := "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_${ghq_platform}_${ghq_architecture}.zip"
ghq_source_path := "${ghq_install_path}/ghq"

# TODO add unzip to base packages, or even bootstrap

# Lines copied from script
$(ghq_source_path) :
	@curl --silent --location --create-dirs --output "${ghq_install_path}/ghq_${ghq_platform}_${ghq_architecture}.zip" "${ghq_download_url}"
	@unzip -p "${ghq_install_path}/ghq_${ghq_platform}_${ghq_architecture}.zip" "ghq_${ghq_platform}_${ghq_architecture}/ghq" >"${ghq_source_path}"
	@chmod +x "${ghq_source_path}"
	@rm "${ghq_install_path}/ghq_${ghq_platform}_${ghq_architecture}.zip"

.PHONY : app-ghq
app-ghq : ${ghq_source_path}

.PHONY : app-ghq-uninstall
app-ghq-uninstall :
	rm ${ghq_source_path}

.PHONY : test-app-ghq
test-app-ghq :
	[[ -x ${HOME}/.local/bin/ghq ]] || exit 1
	ghq --version
	@echo "Testing successful."
