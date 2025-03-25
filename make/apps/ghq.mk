# Install steps taken from https://github.com/kajisha/asdf-ghq/blob/master/bin/install

# variables copied from asdf-ghq
version := ${GHQ_VERSION}
platform := $(shell echo ${OS} | tr A-Z a-z)
architecture := $(if $(filter x86_64,$(ARCHITECTURE)),amd64,$(ARCHITECTURE))
install_path := ${PREFIX}
download_url := "https://github.com/x-motemen/ghq/releases/download/v${version}/ghq_${platform}_${architecture}.zip"
source_path := "${install_path}/ghq"

# TODO add unzip to base packages, or even bootstrap

# Lines copied from script
$(source_path) :
	@curl --silent --location --create-dirs --output "${install_path}/ghq_${platform}_${architecture}.zip" "${download_url}"
	@unzip -p "${install_path}/ghq_${platform}_${architecture}.zip" "ghq_${platform}_${architecture}/ghq" >"${source_path}"
	@chmod +x "${source_path}"
	@rm "${install_path}/ghq_${platform}_${architecture}.zip"

app-ghq: ${source_path}

app-ghq-test :
	@[[ -x ${HOME}/.local/bin/ghq ]] || exit 1
	@ghq --version
