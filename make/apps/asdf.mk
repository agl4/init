.PHONY : asdf asdf-upgrade asdf-setup-bashrc

ASDF := ${PREFIX}/asdf
ASDF_PLUGINS := ghq nodejs python

TEMPDIR := $(shell mktemp -d)
ASDF_DOWNLOAD_LINK := https://github.com/asdf-vm/asdf/releases/download/${ASDF_VERSION}/asdf-${ASDF_VERSION}-$(shell echo "${OS}" | tr '[:upper:]' '[:lower:]')-arm64.tar.gz

$(ASDF) :
	@curl -sSL ${ASDF_DOWNLOAD_LINK} | gzip -cd | tar -xvf - -C ${PREFIX}

$(ASDF_PLUGINS) : $(ASDF)
	if [ ! -d "$(addprefix ${HOME}/.asdf/plugins/,$@)" ] ; then asdf plugin add $@ ; fi

${HOME}/.tool-versions : $(ASDF_PLUGINS)
	$(info Install tool-versions...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	 asdf install || true

${HOME}/.default-python-packages : ${HOME}/.tool-versions
	$(info update python packages...)
	@install -v -m 0600 share/asdf/requirements.txt "$@"
	pip install --upgrade pip
	pip install --upgrade -r "$@"

${HOME}/.default-npm-packages : ${HOME}/.tool-versions
	$(info Update npm packages...)
	@install -v -m 0600 share/asdf/$(shell basename $@) "$@"
	xargs npm install --global < "$$HOME/.default-npm-packages"
	npm update -g npm
	xargs npm update --global < "$$HOME/.default-npm-packages"

asdf-upgrade: $(ASDF)
	asdf plugin-update --all

ASDF_TARGETS += ${HOME}/.tool-versions asdf-upgrade
ASDF_TARGETS += ${HOME}/.default-python-packages ${HOME}/.default-npm-packages

asdf: $(ASDF_TARGETS)
DESKTOP_TARGETS += asdf
