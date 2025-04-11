# Install steps taken from https://github.com/kajisha/asdf-ghq/blob/master/bin/install

# renovate: datasource=github-releases depName=x-motemen/ghq versioning=semver registryUrl=https://github.com
GHQ_VERSION := 1.8.0

# variables copied from asdf-ghq
platform := $(shell echo ${OS} | tr A-Z a-z)
architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
install_path := ${PREFIX}
download_url := "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_${platform}_${architecture}.zip"
source_path := "${install_path}/ghq"

# TODO add unzip to base packages, or even bootstrap

# Lines copied from script
$(source_path) :
	@curl --silent --location --create-dirs --output "${install_path}/ghq_${platform}_${architecture}.zip" "${download_url}"
	@unzip -p "${install_path}/ghq_${platform}_${architecture}.zip" "ghq_${platform}_${architecture}/ghq" >"${source_path}"
	@chmod +x "${source_path}"
	@rm "${install_path}/ghq_${platform}_${architecture}.zip"

.PHONY : app-ghq
app-ghq : ${source_path}

.PHONY : test-app-ghq
test-app-ghq :
	@[[ -x ${HOME}/.local/bin/ghq ]] || exit 1
	@source ${HOME}/.bashrc && ghq --version
